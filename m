Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269589AbUI3WMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbUI3WMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269484AbUI3WMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:12:22 -0400
Received: from serio.al.rim.or.jp ([202.247.191.123]:3231 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S269589AbUI3WME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:12:04 -0400
Message-ID: <415C84AB.4060808@yk.rim.or.jp>
Date: Fri, 01 Oct 2004 07:11:55 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chiaki <ishikawa@yk.rim.or.jp>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Subject: Re: FSCK message suppressed during booting? (2.6.9-rc2)
References: <E1CCtxn-00075V-00@calista.eckenfels.6bone.ka-ip.net> <415C2B6C.6050401@yk.rim.or.jp> <415C6E30.1020705@yk.rim.or.jp>
In-Reply-To: <415C6E30.1020705@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chiaki wrote:
> Chiaki wrote:
> 
>> Bernd Eckenfels wrote:
>>
>>> In article <415B5034.6060809@yk.rim.or.jp> you wrote:
>>>
>>>> That is, under previous 2.4.xx kernel, I would have gotten
>>>> "The disk was not unmounted cleanly. Running fsck." or
>>>> some such message and fsck printed its
>>>> progress bar using ASCII characters.
>>>
>>>
>>>
>>>
>>> Well, this is not a kernel function, your Distribution is calling 
>>> fsck in
>>> the bootup scripts, and fsck is calling the filesystem specific
>>> implementation and this is checking if fsck is needed.
>>>
>>> If you do not get this messages anymore contact your linux distribution
>>> provider.
>>>
>>>
>>
>> Thank you for the comment.
>>
>> Well, I have installed 2.6.9-rc2 on my own after having used
>> Debian with my own updated kernel 2.4.2x series for a few years now.
>> I certainly upgraded moduleutil and other packages to run
>> 2.6.9-rc2, but have not specifically updated fsck.
>> (I DID ran apt-get -u update and apt-get -u upgrade to pick up
>> the latest packages a week ago or so.).
>>
>> Agreed that the starting fsck under stock Debian scheme
>> may depend on 2.4.xx features which may not be available
>> on 2.6.yy series kernel. I will get in contact with fsck
>> package (or boot script) maintainer to see
>> if we can improve this.
>>
>>  >Do you habe maybe a journalling filesystem? Or do you have set some 
>> flags to
>>  > force the skip of fsck (/fastboot)
>>  >
>>
>> Well, I am running 2.6.9-rc2 from loadlin as follows.
>>
>> loadlin 269rc2 root=/dev/sda6 ro vga=3 scsihosts=sym53c8xx:tmscsim
>>
>> I noticed the fsck message lines were missing on the reboot after
>> a hard-hung forced me to hit reset button in the end.
>> The message lines were missing, but it seems that fsck
>> certainly was running invisibly. Thus the
>> boot sequence halted as if the computer got hung again
>> until fsck finished and bootting continued. This was very
>> annoying.
>>
> 
> 
> OK, maybe I was not clear enough in the first post.
> 
> Fsck seemed to run during the reboot
> after a reset button was hit to recover from a hard hung.
> 
> However, NO OUTPUT message from fsck is shown on the console.
> It progressed silently : I could hear the disk access
> (head movement) and this made me very uncomfortable.
> With a test kernel accessing disk furiously without
> telling me what it does during otherwise smooth booting
> process after a hard reset, I may need to consider
> the chance of kernel running wild and trashing the file system.
> So that is why I rebooted the system using 2.4.xx which I have
> used for quite a long time to make sure that the file system(s)
> are fsck'ed and then cleanly remounted.
> 
> Anyway, before contacting the Debian package maintainer, I found
> the following.
> IF during the booting the environment variable TERM
> is set to "dumb", "network", "unknown" or not set at all
> the progressive horizontal bar display (-C option to fsck)
> is disabled in the Debian startup script.
> 
> Maybe the TERM setup for console during booting has changed between
> kernel 2.4.2x and 2.6.9-rc2?
> 
> 
> A little more detail:
> 
> I checked the Debian startup script myself.
> Now I notice that if the fsck is invoked in a startup script and $TERM is
> set to "dumb" or "network" or "unknown" or not set at all, this
> progress bar display (-C option to fsck)
> is not done by the Debian start up script.
> 
> Maybe between 2.4.2x and 2.6.9-rc2,
> the boot console $TERM setting changed?
> 
> --- begin Excerpt from /etc/init.d/checkroot.sh
> 
> if [ "$doswap" = yes ]
> then
>     [ "$VERBOSE" != no ] && echo "Activating swap."
>     swapon -a 2> /dev/null
> fi
> 
>     ... omission...
> 
> #
> #    The actual checking is done here.
> #
> if [ "$rootcheck" = yes ]
> then
>     if [ -f /forcefsck ]
>     then
>         force="-f"
>     else
>         force=""
>     fi
> 
>     if [ "$FSCKFIX" = yes ]
>     then
>         fix="-y"
>     else
>         fix="-a"
>     fi
> 
>     spinner="-C"
>     case "$TERM" in
>         dumb|network|unknown|"")
>             spinner="" ;;
>     esac
>     # This Linux/s390 special case should go away.
>     if [ "${KERNEL}:${MACHINE}" = Linux:s390 ]
>     then
>         spinner=""
>     fi
> 
>     echo "Checking root file system..."
>     fsck $spinner $force $fix -t $roottype $rootdev
>     FSCKCODE=$?
> 
> --- end Excerpt
> 
> 
> I think I saw Activating Swap message.  But I am not sure if I saw
> "Checking root file system..." message during a reboot after the RESET
> button was hit due to a hung.  I was not paying attention to that.
> But definitely, I didn't see at all the
> growing ASCII character-base horizontal bar with a spinning char on
> the right (/ - \ |).  This is a way to show progress bar. This is
> shown with the -C option to fsck. I usually see this progressive
> bar for fsck during reboot under 2.4.2x kernel.
> So obviously "-C" is reset to "". I am NOT using s390 :-)
> 
> (OR the output from this shell is eaten by some other mechanism.
>  I need to understand the stdio/stdout setting of the shell
>  invoking this script further.)
> 
> I will check with the maintainer of Debian package further.
> 

I submited a bug report to Debian package bug tracking system.

But here is another data point to clarify the above comment.
I rebooted the system after "touch /forcefsck"
to see the exact message shown just before fsck is run silently.

The output from shows that output using "echo" inside
checkroot.sh is not shown. Strange...

The last few lines just before the fsck run.

NET: Registered Protocol Family 17.
VFS: Mounted root (ext 2 file system readonly)
Freeing unused kernel memory: 152k freed.
Adding 2000052k swap on /dev/hda12: Pirority -1. extents: 1
(Then long pause for running fsck on my root partition.)
...various module insertion messages.
(Then another long pause for checking other mounted
  partitions.)

So, a simple output from
echo  "Checking root filesystem ..." is not shown.

I inserted an "echo TERM=$TERM" to see what is
the TERM variable setting and this was not output at all, too.
Very strange.
Obviously, Adding 2000052k swap on /dev/hda12 came
from "swapon -a" command.

Something weired is going on here.

I will wait the response from Debian package
maintainer.






-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
