Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSAHPUb>; Tue, 8 Jan 2002 10:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288099AbSAHPUW>; Tue, 8 Jan 2002 10:20:22 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:5388 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S288097AbSAHPUG>; Tue, 8 Jan 2002 10:20:06 -0500
Date: Tue, 8 Jan 2002 09:19:57 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        "M.H.VanLeeuwen" <vanl@megsinet.net>, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Update Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108091956.A859@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com> <20020103232601.B12884@asooo.flowerfire.com> <20020104140321.51cb8bf0.skraw@ithnet.com> <20020104175050.A3623@asooo.flowerfire.com> <20020105160833.0800a182.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020105160833.0800a182.skraw@ithnet.com>; from skraw@ithnet.com on Sat, Jan 05, 2002 at 04:08:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I stayed at work all night banging out tests on a few of our machines
here.  I took 2.4.18-pre2 and 2.4.18-pre2 with the vmscan patch from
"M.H.VanLeeuwen" <vanl@megsinet.net>.

My sustained test consisted of this type of load:

	ls -lR / > /dev/null &
	/usr/bin/slocate -u -f "nfs,smbfs,ncpfs,proc,devpts" -e "/tmp,/var/tmp,/usr/tmp,/afs,/net" &
	dd if=/dev/sda3 of=/sda3 bs=1024k &
	# Hit TUX on this machine repeatedly; html page with 1000 images
	# Wait for memory to be mostly used by buff/page cache
	./a.out &
	# repeat finished commands -- keep all commands running
	# after a.out finishes, alow buff/page to refill before repeating

The a.out in this case is a little program (attached, c.c) to allocate
and write to an amount of memory equal to physical RAM.  The example I
chose below is from a 2xP3/600 with 1GB of RAM and 2GB swap.

This was not a formal benchmark -- I think benchmarks have been
presented before by other folks, and looking at benchmarks does not
necessarily indicate the real-world problems that exist.  My intent was
to reproduce the issues I've been seeing, and then apply the MH (and
only the MH) patch and observe.

2.4.18-pre2

Once slocate starts and gets close to filling RAM with buffer/page
cache, kupdated and kswapd have periodic spikes of 50-100% CPU.

When a.out starts, kswapd and kupdated begin to eat significant portions
of CPU (20-100%) and I/O becomes more and more sluggish as a.out
allocates.

When a.out uses all free RAM and should begin eating cache, significant
swapping begins and cache is not decreased significantly until the
machine goes 100-200MB into swap.

Here are two readprofile outputs, sorted by ticks and load.

229689 default_idle                             4417.0962
  4794 file_read_actor                           18.4385
   405 __rdtsc_delay                             14.4643
  3763 do_anonymous_page                         14.0410
  3796 statm_pgd_range                            9.7835
  1535 prune_icache                               6.9773
   153 __free_pages                               4.7812
  1420 create_bounce                              4.1765
   583 sym53c8xx_intr                             3.9392
   221 atomic_dec_and_lock                        2.7625
  5214 generic_file_write                         2.5659

273464 total                                      0.1903
234168 default_idle                             4503.2308
  5298 generic_file_write                         2.6073
  4868 file_read_actor                           18.7231
  3799 statm_pgd_range                            9.7912
  3763 do_anonymous_page                         14.0410
  1535 prune_icache                               6.9773
  1526 shrink_cache                               1.6234
  1469 create_bounce                              4.3206
   643 rmqueue                                    1.1320
   591 sym53c8xx_intr                             3.9932
   505 __make_request                             0.2902


2.4.18-pre2 with MH

With the MH patch applied, the issues I witnessed above did not seem to
reproduce.  Memory allocation under pressure seemed faster and smoother.
kswapd never went above 5-15% CPU.  When a.out allocated memory, it did
not begin swapping until buffer/page cache had been nearly completely
cannibalized.

And when a.out caused swapping, it was controlled and behaved like you
would expect the VM to bahave -- slowly swapping out unused pages
instead of large swap write-outs without the patch.

Martin, have you done throughput benchmarks with MH/rmap/aa, BTW?

But both kernels still seem to be sluggish when it comes to doing small
I/O operations (vi, ls, etc) during heavy swapping activity.

Here are the readprofile results:

206243 default_idle                             3966.2115
  6486 file_read_actor                           24.9462
   409 __rdtsc_delay                             14.6071
  2798 do_anonymous_page                         10.4403
   185 __free_pages                               5.7812
  1846 statm_pgd_range                            4.7577
   469 sym53c8xx_intr                             3.1689
   176 atomic_dec_and_lock                        2.2000
   349 end_buffer_io_async                        1.9830
   492 refill_inactive                            1.8358
    94 system_call                                1.8077

245776 total                                      0.1710
216238 default_idle                             4158.4231
  6486 file_read_actor                           24.9462
  2799 do_anonymous_page                         10.4440
  1855 statm_pgd_range                            4.7809
  1611 generic_file_write                         0.7928
   839 __make_request                             0.4822
   820 shrink_cache                               0.7374
   540 rmqueue                                    0.9507
   534 create_bounce                              1.5706
   492 refill_inactive                            1.8358
   487 sym53c8xx_intr                             3.2905


There may be significant differences in the profile outputs for those
with VM fu.  

Summary: MH swaps _after_ cache has been properly cannibalized, and
swapping activity starts when expected and is properly throttled.
kswapd and kupdated don't seem to go into berserk 100% CPU mode.

At any rate, I now have the MH patch (and Andrew Morton's mini-ll and
read-latency2 patches) in production, and I like what I see so far.  I'd
vote for them to go into 2.4.18, IMHO.  Maybe the full low-latency patch
if it's not truly 2.5 material.

My next cook-off will be with -aa and rmap, although if the rather small
MH patch fixes my last issues it may be worth putting all VM effort into
a 2.5 VM cook-off. :)  Hopefully the useful stuff in -aa can get pulled
in at some point soon, though.

Thanks much to Martin H. VanLeeuwen for his patch and Stephan von
Krawczynski for his recommendations.  I'll let MH cook for a while and
I'll follow up later.
-- 
Ken.
brownfld@irridia.com

c.c:

#include <stdio.h>

#define MB_OF_RAM 1024

int
main()
{
	long stuffsize = MB_OF_RAM * 1048576 ;
	char *stuff ;

	if ( stuff = (char *)malloc( stuffsize ) ) {
		long chunksize = 1048576 ;
		long c ;

		for ( c=0 ; c<chunksize ; c++ )
			*(stuff+c) = '\0' ;
		/* hack; last chunk discarded if stuffsize%chunksize != 0 */
		for ( ; (c+chunksize)<stuffsize ; c+=chunksize )
			memcpy( stuff+c, stuff, chunksize );
	
		sleep( 120 );
	}
	else
		printf("OOPS\n");

	exit( 0 );
}


On Sat, Jan 05, 2002 at 04:08:33PM +0100, Stephan von Krawczynski wrote:
[...]
| I am pretty impressed by Martins test case where merely all VM patches fail
| with the exception of his own :-) The thing is, this test is not of nature
| "very special" but more like "system driven to limit by normal processes". And
| this is the real interesting part about it.
[...]
