Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUAJOtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUAJOtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:49:10 -0500
Received: from rat-5.inet.it ([213.92.5.95]:17108 "EHLO rat-5.inet.it")
	by vger.kernel.org with ESMTP id S265177AbUAJOsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:48:51 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 10 Jan 2004 15:48:33 +0100
User-Agent: KMail/1.5.2
Cc: gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <20040108171728.54a72cf7.akpm@osdl.org> <1073675705.14637.8.camel@dyn319250.beaverton.ibm.com>
In-Reply-To: <1073675705.14637.8.camel@dyn319250.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101548.33458.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 20:15, Ram Pai wrote:
> On Thu, 2004-01-08 at 17:17, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > > Well this is my theory, somebody should validate it,
> >
> > One megabyte seems like far too litte memory to be triggering the
> > effect which you describe.  But yes, the risk is certainly there.
> >
> > You could verify this with:
>
> I cannot exactly reproduce what Pualo Ornati is seeing.
>
> Pualo: Request you to validate the following,
>
> 1) see whether you see a regression with files replacing the
>    cat command in your script with
>        dd if=big_file of=/dev/null bs=1M count=256
>
> 2) and if you do, check if you see a bunch of 'eek' with Andrew's
>         following patch. (NOTE: without reverting the changes
>         in filemap.c)
>
> -------------------------------------------------------------------------
>-
>
> --- 25/mm/filemap.c~a   Thu Jan  8 17:15:57 2004
> +++ 25-akpm/mm/filemap.c        Thu Jan  8 17:16:06 2004
> @@ -629,8 +629,10 @@ find_page:
>                         handle_ra_miss(mapping, ra, index);
>                         goto no_cached_page;
>                 }
> -               if (!PageUptodate(page))
> +               if (!PageUptodate(page)) {
> +                       printk("eek!\n");
>                         goto page_not_up_to_date;
> +               }
>  page_ok:
>                 /* If users can be writing to this page using arbitrary
>                  * virtual addresses, take care about potential aliasing
>
> -------------------------------------------------------------------------

Ok, this patch seems for -mm tree... I have applied it by hand (on a vanilla 
2.6.1-rc1).

For my tests I've used this script:

#!/bin/sh

RA_VALS="256 128 64"
FILE="/big_file"
SIZE=`stat -c '%s' $FILE`
NR_TESTS="3"
LINUX=`uname -r`

echo "HD test for Penguin $LINUX"

killall5
sync
sleep 3

for ra in $RA_VALS; do
    hdparm -a $ra /dev/hda
    for i in `seq $NR_TESTS`; do
    echo "_ _ _ _ _ _ _ _ _"
	./fadvise $FILE 0 $SIZE dontneed
	time dd if=$FILE of=/dev/null bs=1M count=256
    done
    echo "________________________________"
done


RESULTS (2.6.0 / 2.6.1-rc1)

HD test for Penguin 2.6.0

/dev/hda:
 setting fs readahead to 256
 readahead    = 256 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.427s
user	0m0.002s
sys	0m1.722s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.963s
user	0m0.000s
sys	0m1.760s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.291s
user	0m0.001s
sys	0m1.713s
________________________________

/dev/hda:
 setting fs readahead to 128
 readahead    = 128 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.910s
user	0m0.003s
sys	0m1.882s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.693s
user	0m0.003s
sys	0m1.860s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.733s
user	0m0.004s
sys	0m1.922s
________________________________

/dev/hda:
 setting fs readahead to 64
 readahead    = 64 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.107s
user	0m0.000s
sys	0m2.026s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.227s
user	0m0.004s
sys	0m1.984s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m9.152s
user	0m0.002s
sys	0m2.013s
________________________________


HD test for Penguin 2.6.1-rc1

/dev/hda:
 setting fs readahead to 256
 readahead    = 256 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.984s
user	0m0.002s
sys	0m1.751s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.704s
user	0m0.002s
sys	0m1.766s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.886s
user	0m0.002s
sys	0m1.731s
________________________________

/dev/hda:
 setting fs readahead to 128
 readahead    = 128 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.120s
user	0m0.001s
sys	0m1.830s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.596s
user	0m0.005s
sys	0m1.764s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.481s
user	0m0.002s
sys	0m1.727s
________________________________

/dev/hda:
 setting fs readahead to 64
 readahead    = 64 (on)
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.361s
user	0m0.006s
sys	0m1.782s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.655s
user	0m0.002s
sys	0m1.778s
_ _ _ _ _ _ _ _ _
256+0 records in
256+0 records out

real	0m11.369s
user	0m0.004s
sys	0m1.798s
________________________________


As you can see 2.6.0 performances increase setting readahead from 256 to 64 
(64 seems to be the best value) while 2.6.1-rc1 performances don't change 
too much.

I noticed that on 2.6.0 with readahead setted at 256 the HD LED blinks 
during the data transfer while with lower values (128 / 64) it stays on.
Instead on 2.6.1-rc1 HD LED blinks with almost any values (I must set it at 
8 to see it stable on).

ANSWERS:

1) YES... I see a regression with files ;-(

2) YES, I see also a bunch of "eek!" (a mountain of "eek!")

Bye

-- 
	Paolo Ornati
	Linux v2.4.24

