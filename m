Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUIDXKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUIDXKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 19:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIDXKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 19:10:45 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:21966 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264386AbUIDXKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 19:10:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Rick Lindsley <ricklind@us.ibm.com>
Subject: latency.c [was: Re: 2.6.9-rc1-mm1]
Date: Sun, 5 Sep 2004 01:10:07 +0200
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
References: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
In-Reply-To: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PtkOBDZk9H7xlFu"
Message-Id: <200409050110.07728.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PtkOBDZk9H7xlFu
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 of August 2004 23:54, Rick Lindsley wrote:
[- snip -]
> You can also pick up the program "latency.c" at
> 
>     http://eaglet.rain.com/rick/linux/schedstat/v9/latency.c
> 
> With these two things in hand, you should be able to measure the latency
> on 2.6.8.1 of a particular process.
> 
> A patch is not necessary for 2.6.9-rc1-mm1 (schedstats is already in there)
> but you will need to config the kernel to use it.  Then retrieve a slightly
> different latency.c:
>     
>     http://eaglet.rain.com/rick/linux/schedstat/v10/latency.c
> 
> since 2.6.9-rc1-mm1 output format is different (as you noted, it's a
> different scheduler.)  Then you should be able to see if the latency of
> a particular process (updatedb, for instance) changes.

I've fiddled a bit with both the latency.c programs.  I've added some options 
to them etc.  In particular, now you can specify a program to run and monitor 
instead of a pid, which is handy if you need to monitor processes that exit 
quickly.  Everything is documented in the sources (attached).  I thought you 
might find this useful. :-)

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman

--Boundary-00=_PtkOBDZk9H7xlFu
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="latency-v9.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="latency-v9.c"

/*
 * latency -- measure the scheduling latency of a particular process from
 *	the extra information provided in /proc/<pid>stat by version 4 of
 *	the schedstat patch. PLEASE NOTE: This program does NOT check to
 *	make sure that extra information is there; it assumes the last
 *	three fields in that line are the ones it's interested in.  Using
 *	it on a kernel that does not have the schedstat patch compiled in
 *	will cause it to happily produce bizarre results.
 *
 *	Note too that this is known to work only with versions 4 and 5
 *	of the schedstat patch, for similar reasons.
 *
 *	This currently monitors only one pid at a time but could easily
 *	be modified to do more.
 */
/*
 * Modified by Rafael J. Wysocki <rjw@sisk.pl> on September 4, 2004
 * Added options:
 * -o -- allows one to specify a log file to store the results in
 * -n -- turns on a numerical-only format (mutually exclusive with -v)
 * -r -- allows one to specify a program to run and monitor for latencies instead of a pid
 *
 * The -r option is handy if you want to monitor a process that exits quickly (eg. gcc or tar etc.).
 * The -o is necessary if -r is specified to separate the output of latency.c with the output of the
 * monitored process
 * The output generated with the -n option may be useful for creating graphs
 */
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <getopt.h>
#include <string.h>
#include <strings.h>

#define STRLEN 256

char procbuf[512];
char statname[64];
char progpath[STRLEN];
char logpath[STRLEN];
char *Progname;
FILE *fp, *outp;

void usage()
{
    fprintf(stderr, "Usage: %s [{-v|-n} ][-s sleeptime ][-o logfile ]{-r program|<pid>}\n", Progname);
    exit(-1);
}

/*
 * execute() is used to spawn a new process that will be monitored for latencies
 * The new process' command line is passed in *file
 */

void execute(char *file)
{
    char *ptr, **args;
    int cnt =  1, j;

    /* See how many arguments are to be passed */
    for (ptr = file; *ptr; ptr++)
	if (*ptr == ' ')  cnt++;
    args = (char **)malloc((cnt + 1) * sizeof(char *));
    /* Extract the arguments */
    args[0] =  file;
    ptr =  file;
    for (j = 1; j < cnt; j++) {
	ptr =  index(ptr, ' ');
	*ptr++ = '\0';
	args[j] =  ptr;
    }
    args[j] =  NULL;
    /* Run the program */
    execvp(args[0], args);
}

/*
 * get_stats() -- we presume that we are interested in the last three
 *	fields of the line we are handed, and further, that they contain
 *	only numbers and single spaces.
 */
void get_stats(char *buf, char *id, unsigned int *run_ticks,
	       unsigned int *wait_ticks, unsigned int *nran)
{
    char *ptr;

    ptr = index(buf, ')') + 1;
    *ptr = 0;
    strcpy(id, buf);
    *ptr = ' ';

    ptr = rindex(buf,' ');
    if (!ptr) return;

    *nran = atoi(ptr--);

    while (isdigit(*ptr) && --ptr != buf);
    if (ptr == buf) return;

    *wait_ticks = atoi(ptr--);

    while (isdigit(*ptr) && --ptr != buf);
    if (ptr == buf) return;

    *run_ticks = atoi(ptr);
}

main(int argc, char *argv[])
{
    int c;
    unsigned int sleeptime = 5, pid = 0, verbose = 0, numeric = 0, runprog = 0, log = 0;
    char id[32];
    unsigned int run_ticks, wait_ticks, nran;
    unsigned int orun_ticks=0, owait_ticks=0, oran=0;

    Progname = argv[0];
    id[0] = 0;
    while ((c = getopt(argc, argv, "s:vnr:o:")) != -1) {
	switch (c) {
	    case 's':
		sleeptime = atoi(optarg);
		break;
	    case 'v':
		verbose++;
		break;
	    case 'n':
		numeric++;
		break;
	    case 'r':
		strncpy(progpath, optarg, STRLEN - 1);
		progpath[STRLEN - 1] =  '\0';
		runprog++;
		break;
	    case 'o':
		strncpy(logpath, optarg, STRLEN - 1);
		logpath[STRLEN - 1] =  '\0';
		log++;
		break;
	    default:
		usage();
	}
    }

    if (verbose && numeric)
	usage();

    if (runprog) {
	pid =  fork();
	if (pid < 0) {
	    puts("fork() failed");
	    exit(pid);
	}
	if (!pid)
	    execute(progpath);
    }
    else if (optind < argc) {
	pid = atoi(argv[optind]);
    }

    if (!pid)
	usage();

    outp =  NULL;
    if (log)
	outp =  fopen(logpath, "w");
    if (!outp) {
	outp =  stdout;
	log = 0;
    }
    /*
     * now just spin collecting the stats
     */
    sprintf(statname,"/proc/%d/stat", pid);
    while (fp = fopen(statname, "r")) {
	    if (runprog)
		waitpid(pid, NULL, WNOHANG);

	    if (!fgets(procbuf, sizeof(procbuf), fp))
		    break;

	    get_stats(procbuf, id, &run_ticks, &wait_ticks, &nran);

	    if (verbose)
		fprintf(outp, "%s %d(%d) %d(%d) %d(%d) %4.2f %4.2f\n",
		    id, run_ticks, run_ticks - orun_ticks,
		    wait_ticks, wait_ticks - owait_ticks,
		    nran, nran - oran,
		    nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    else if (numeric)
		fprintf(outp, "%s %4.2f %4.2f\n",
		    id, nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    else
		fprintf(outp, "%s avgrun=%4.2fms avgwait=%4.2fms\n",
		    id, nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    fclose(fp);
	    oran = nran;
	    orun_ticks = run_ticks;
	    owait_ticks = wait_ticks;
	    sleep(sleeptime);

	    if (runprog)
		waitpid(pid, NULL, WNOHANG);

	    fp = fopen(statname,"r");
	    if (!fp)
		    break;
    }
    if (log)
	fclose(outp);
    if (id[0])
	printf("Process %s has exited.\n", id);
    else
	printf("Process %d does not exist.\n", pid);
    exit(0);
}

--Boundary-00=_PtkOBDZk9H7xlFu
Content-Type: text/x-csrc;
  charset="iso-8859-2";
  name="latency-v10.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="latency-v10.c"

/*
 * latency -- measure the scheduling latency of a particular process from
 *	the extra information provided in /proc/<pid>stat by version 4 of
 *	the schedstat patch. PLEASE NOTE: This program does NOT check to
 *	make sure that extra information is there; it assumes the last
 *	three fields in that line are the ones it's interested in.  Using
 *	it on a kernel that does not have the schedstat patch compiled in
 *	will cause it to happily produce bizarre results.
 *
 *	Note too that this is known to work only with versions 4 and 5
 *	of the schedstat patch, for similar reasons.
 *
 *	This currently monitors only one pid at a time but could easily
 *	be modified to do more.
 */
/*
 * Modified by Rafael J. Wysocki <rjw@sisk.pl> on September 4, 2004
 * Added options:
 * -o -- allows one to specify a log file to store the results in
 * -n -- turns on a numerical-only format (mutually exclusive with -v)
 * -r -- allows one to specify a program to run and monitor for latencies instead of a pid
 *
 * The -r option is handy if you want to monitor a process that exits quickly (eg. gcc or tar etc.).
 * The -o is necessary if -r is specified to separate the output of latency.c with the output of the
 * monitored process
 * The output generated with the -n option may be useful for creating graphs
 */
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <getopt.h>
#include <string.h>
#include <strings.h>

#define STRLEN 256

extern char *index(), *rindex();
char procbuf[512];
char statname[64];
char progpath[STRLEN];
char logpath[STRLEN];
char *Progname;
FILE *fp, *outp;

void usage()
{
    fprintf(stderr, "Usage: %s [{-v|-n} ][-s sleeptime ][-o logfile ]{-r program|<pid>}\n", Progname);
    exit(-1);
}

/*
 * execute() is used to spawn a new process that will be monitored for latencies
 * The new process' command line is passed in *file
 */

void execute(char *file)
{
    char *ptr, **args;
    int cnt =  1, j;

    /* See how many arguments are to be passed */
    for (ptr = file; *ptr; ptr++)
	if (*ptr == ' ')  cnt++;
    args = (char **)malloc((cnt + 1) * sizeof(char *));
    /* Extract the arguments */
    args[0] =  file;
    ptr =  file;
    for (j = 1; j < cnt; j++) {
	ptr =  index(ptr, ' ');
	*ptr++ = '\0';
	args[j] =  ptr;
    }
    args[j] =  NULL;
    /* Run the program */
    execvp(args[0], args);
}

/*
 * get_stats() -- we presume that we are interested in the first three
 *	fields of the line we are handed, and further, that they contain
 *	only numbers and single spaces.
 */
void get_stats(char *buf, unsigned int *run_ticks, unsigned int *wait_ticks,
    unsigned int *nran)
{
    char *ptr;

    /* sanity */
    if (!buf || !run_ticks || !wait_ticks || !nran)
	return;

    /* leading blanks */
    ptr = buf;
    while (*ptr && isblank(*ptr))
	ptr++;

    /* first number -- run_ticks */
    *run_ticks = atoi(ptr);
    while (*ptr && isdigit(*ptr))
	ptr++;
    while (*ptr && isblank(*ptr))
	ptr++;

    /* second number -- wait_ticks */
    *wait_ticks = atoi(ptr);
    while (*ptr && isdigit(*ptr))
	ptr++;
    while (*ptr && isblank(*ptr))
	ptr++;

    /* last number -- nran */
    *nran = atoi(ptr);
}

/*
 * get_id() -- extract the id field from that /proc/<pid>/stat file
 */
void get_id(char *buf, char *id)

{
    char *ptr;

    /* sanity */
    if (!buf || !id)
	return;

    ptr = index(buf, ')') + 1;
    *ptr = 0;
    strcpy(id, buf);
    *ptr = ' ';

    return;
}

main(int argc, char *argv[])
{
    int c;
    unsigned int sleeptime = 5, pid = 0, verbose = 0, numeric = 0, runprog = 0, log = 0;
    char id[32];
    unsigned int run_ticks, wait_ticks, nran;
    unsigned int orun_ticks=0, owait_ticks=0, oran=0;

    Progname = argv[0];
    id[0] = 0;
    while ((c = getopt(argc,argv,"s:vnr:o:")) != -1) {
	switch (c) {
	    case 's':
		sleeptime = atoi(optarg);
		break;
	    case 'v':
		verbose++;
		break;
	    case 'n':
		numeric++;
		break;
	    case 'r':
		strncpy(progpath, optarg, STRLEN - 1);
		progpath[STRLEN - 1] =  '\0';
		runprog++;
		break;
	    case 'o':
		strncpy(logpath, optarg, STRLEN - 1);
		logpath[STRLEN - 1] =  '\0';
		log++;
		break;
	    default:
		usage();
	}
    }

    if (verbose && numeric)
	usage();

    if (runprog) {
	pid =  fork();
	if (pid < 0) {
	    puts("fork() failed");
	    exit(pid);
	}
	if (!pid)
	    execute(progpath);
    }
    else if (optind < argc) {
	pid = atoi(argv[optind]);
    }

    if (!pid)
	usage();

    outp =  NULL;
    if (log)
	outp =  fopen(logpath, "w");
    if (!outp) {
	outp =  stdout;
	log = 0;
    }

    sprintf(statname, "/proc/%d/stat", pid);
    if (fp = fopen(statname, "r")) {
	if (fgets(procbuf, sizeof(procbuf), fp))
	    get_id(procbuf, id);
	fclose(fp);
    }

    /*
     * now just spin collecting the stats
     */
    sprintf(statname, "/proc/%d/schedstat", pid);
    while (fp = fopen(statname, "r")) {
	    if (runprog)
		waitpid(pid, NULL, WNOHANG);

	    if (!fgets(procbuf, sizeof(procbuf), fp))
		    break;

	    get_stats(procbuf, &run_ticks, &wait_ticks, &nran);

	    if (verbose)
		fprintf(outp, "%s %d(%d) %d(%d) %d(%d) %4.2f %4.2f\n",
		    id, run_ticks, run_ticks - orun_ticks,
		    wait_ticks, wait_ticks - owait_ticks,
		    nran, nran - oran,
		    nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    else if (numeric)
		fprintf(outp, "%s %4.2f %4.2f\n",
		    id, nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    else
		fprintf(outp, "%s avgrun=%4.2fms avgwait=%4.2fms\n",
		    id, nran - oran ?
			(double)(run_ticks-orun_ticks)/(nran - oran) : 0,
		    nran - oran ?
			(double)(wait_ticks-owait_ticks)/(nran - oran) : 0);
	    fclose(fp);
	    oran = nran;
	    orun_ticks = run_ticks;
	    owait_ticks = wait_ticks;
	    sleep(sleeptime);

	    if (runprog)
		waitpid(pid, NULL, WNOHANG);

	    fp = fopen(statname,"r");
	    if (!fp)
		    break;
    }
    if (log)
	fclose(outp);
    if (id[0])
	printf("Process %s has exited.\n", id);
    else
	printf("Process %d does not exist.\n", pid);
    exit(0);
}

--Boundary-00=_PtkOBDZk9H7xlFu--
