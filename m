Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbSIVVzR>; Sun, 22 Sep 2002 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264563AbSIVVzR>; Sun, 22 Sep 2002 17:55:17 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:34487 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264550AbSIVVzN>; Sun, 22 Sep 2002 17:55:13 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Sun, 22 Sep 2002 23:59:16 +0200
User-Agent: KMail/1.4.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <78206124.1032689516@[10.10.2.3]> <85905225.1032697215@[10.10.2.3]>
In-Reply-To: <85905225.1032697215@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_S21V9M5F6YSX6TPPYJQ2"
Message-Id: <200209222359.16296.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_S21V9M5F6YSX6TPPYJQ2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 22 September 2002 21:20, Martin J. Bligh wrote:
> I tried putting back the current->node logic now that we have
> the correct node IDs, but it made things worse (not as bad as
> before, but ... looks like we're still allocing off the wrong
> node.

Thanks a lot for the testing! It looks like something is still
wrong. NUMAQ suffers a lot more from hops across the nodes than
the Azusa therefore I expect it is more sensitive to initial
load balancing errors.

The easiest thing to try is "nodpol -P 2" in the shell before
running the test. This changes the initial load balancing policy
from exec() to fork() ("nodpol -P 0" gets you back to the default).

A bit more difficult is tuning the scheduler parameters which can
be done pretty simply by changing the __node_distance matrix. A first
attempt could be: 10 on the diagonal, 100 off-diagonal. This leads to
larger delays when stealing from a remote node.

Anyhow, it would be good to understand what is going on and maybe
simpler tests than a kernel compile can reveal something. Or looking
into at the /proc/sched/load/rqNN files (you need the patch I posted
a few mails ago).

I'll modify alloc_pages not to take into acount the kernel threads
in the mean time.

Regards,
Erich

> This run is the last one in the list.
>
> Virgin:
> Elapsed: 20.82s User: 191.262s System: 59.782s CPU: 1206.4%
>   7059 do_anonymous_page
>   4459 page_remove_rmap
>   3863 handle_mm_fault
>   3695 .text.lock.namei
>   2912 page_add_rmap
>   2458 rmqueue
>   2119 vm_enough_memory
>
> Both numasched patches, just compile fixes:
> Elapsed: 28.744s User: 204.62s System: 173.708s CPU: 1315.8%
>  38978 do_anonymous_page
>  36533 rmqueue
>  35099 __free_pages_ok
>   5551 page_remove_rmap
>   4694 handle_mm_fault
>   3166 page_add_rmap
>
> Both numasched patches, alloc from local node
> Elapsed: 21.094s User: 195.808s System: 62.41s CPU: 1224.4%
>   7475 do_anonymous_page
>   4564 page_remove_rmap
>   4167 handle_mm_fault
>   3467 .text.lock.namei
>   2520 page_add_rmap
>   2112 rmqueue
>   1905 .text.lock.dec_and_lock
>   1849 zap_pte_range
>   1668 vm_enough_memory
>
> Both numasched patches, hack node IDs, alloc from local node
> Elapsed: 21.918s User: 190.224s System: 59.166s CPU: 1137.4%
>   5793 do_anonymous_page
>   4475 page_remove_rmap
>   4281 handle_mm_fault
>   3820 .text.lock.namei
>   2625 page_add_rmap
>   2028 .text.lock.dec_and_lock
>   1748 vm_enough_memory
>   1713 file_read_actor
>   1672 rmqueue
>
> Both numasched patches, hack node IDs, alloc from current->node
> Elapsed: 24.414s User: 194.86s System: 98.606s CPU: 1201.6%
>  30317 do_anonymous_page
>   6962 rmqueue
>   5190 page_remove_rmap
>   4773 handle_mm_fault
>   3522 .text.lock.namei
>   3161 page_add_rmap

--------------Boundary-00=_S21V9M5F6YSX6TPPYJQ2
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="nodpol.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nodpol.c"

/*-------------------------------------------------------------------------
  Read and set the homenode and the node_policy used for node affine
  scheduling.

  (c) Erich Focht <efocht@ess.nec.de>

  $Id:$
  $Revision:$
  $Log:$

  -------------------------------------------------------------------------*/

#include <linux/config.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>
#include <pwd.h>
#include <sys/prctl.h>
#include <string.h>


static char VersionString[] = "$Revision:$";

void usage(char *exe)
{
	printf("Usage: %s [-n] [-N node] [-p] [-P policy] [pid]\n",
	       exe);
	printf("  -n         : get preferred node for process pid\n");
	printf("  -N         : set preferred node for process pid\n");
	printf("  -p         : get scheduler node_policy for process pid\n");
	printf("  -P         : set scheduler node_policy for process pid\n");
	printf("  pid        : process ID of targetted process (default: parent)\n");
	printf("\n%s\n\n",VersionString);
}

#define MAXPIDS 256

int main(int argc,char *argv[])
{
	int ierr=0, pid[MAXPIDS], policy, numpids=0, i;
	int result;
        extern char *optarg;
        extern int optind;
        int c;
	int getpol=0, getnod=0, setnod=0, setpol=0, help=0, node;

	// set PID to parent process ID of current process, this is what we
	// usually mean to change
	pid[numpids++]=getppid();

        // parse options
        while (( c = getopt(argc, argv, "nN:pP:h")) != EOF ) {
		switch( c ) {
		case 'n':    /* get task->node value */
			getnod=1;
			break;
		case 'N':    /* set task->node value */
			setnod=1;
			sscanf(optarg,"%d",&node);
			break;
		case 'p':    /* get task->node_policy value */
			getpol=1;
			break;
		case 'P':    /* set task->node_policy value */
			setpol=1;
			sscanf(optarg,"%d",&policy);
			break;
		case 'h':
			help=1;
			break;
		default:
			printf("Unknown option %s\n",optarg);
		}
        }
	if (optind<argc) numpids=0;

	while (optind<argc && numpids<MAXPIDS-1)
		sscanf(argv[optind++],"%d",&pid[numpids++]);
		
	if (help) {
		usage(argv[0]);
		exit(0);
	}
	
	if (getnod)
		printf("pid \t node\n");
	if (getpol)
		printf("pid \t policy\n");
	for (i=0;i<numpids;i++) {
		if (getnod)
			if((ierr = prctl(PR_GET_NODE,&result,pid[i])) == 0)
				printf("%d\t%d\n",pid[i],result);
		if (setnod)
			ierr = prctl(PR_SET_NODE,(int)node,pid[i]);
		if (getpol)
			if((ierr = prctl(PR_GET_NODPOL,&result,pid[i])) == 0)
				printf("%d\t%d\n",pid[i],result);
		if (setpol)
			ierr = prctl(PR_SET_NODPOL,(int)policy,pid[i]);
	}
	exit(ierr);
}				

--------------Boundary-00=_S21V9M5F6YSX6TPPYJQ2--

