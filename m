Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTCGCEh>; Thu, 6 Mar 2003 21:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbTCGCEh>; Thu, 6 Mar 2003 21:04:37 -0500
Received: from ip-33-237-104-152.anlai.com ([152.104.237.33]:22788 "EHLO
	exchsh01.viatech.com.cn") by vger.kernel.org with ESMTP
	id <S261432AbTCGCEd>; Thu, 6 Mar 2003 21:04:33 -0500
Message-ID: <C373923C3B6ED611874200010250D52E155E1A@exchsh01.viatech.com.cn>
From: "Guangyu Kang (Shanghai)" <GuangyuKang@viatech.com.cn>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Help please: DVD ROM read difficulty
Date: Fri, 7 Mar 2003 10:14:59 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="GB2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
        Currently I'm working on a DVD player fo LINUX project.
        My player use libc read() function on /dev/hdc, i.e. dvd rom in my
system, to read data.
        The last issue I encountered is difficulties during reading
scratched discs.
        Such disc will cause the dvd rom drive get ECC error (code = 0x40)
when perorming the read action.
        And the kernel will keep retrying to get the correct data from the
disc.

        This is not what I want. In the worst case, the player's input
thread is trapped in the kernel trying to read data, seems even won't get
out from kernel for ever.
        Then the player is stalled and will not output anything, too bad.
        The read() function should report fail and return quickly when ECC
error occurs.
        This is generally the require for real time data transfer, data loss
is acceptable and delay is not acceptable.

        I drilled into the file /linux/drivers/ide/ide-cd.c and modified the
function cdrom_decode_status(), make it abort on senskey==HARDWARE_ERROR. It
do aborts, but the read() function do not return -1, it just return part of
the data read.
        What even worse is that there is too much latency. Normally there
will be a bunch of consecutive bad blocks ( logical block on DVD,
2048Bytes), each is read according to a *request* from system cache
mechanism, and each cause a DVD drive hardware time out ( about 10 seconds.
). This is still unacceptable.

        So, the target is to:
                Abort the whole read() call.
                Report FAIL to player. ( The player can do a jump and get to
some good position on the disc. )

        For abort:
                May be I can do a cdrom_end_request() on every local queue
element, thus abort to deal with all data to be read in the current read()
syscall, holding the request lock in hand and unlock it after last request
is ended.

                >>>>The first question is: WILL THIS WORK, and will it work
SAFELY?

        For report FAIL:
                >>>>The second questino is: HOW TO?
                I did not find any way to report this when the driver start
to read data, this should be due to the kernel archeticture, IMHO.
                But I am a newbie to this part of kernel, so I believe there
will be someone have the idea.

        And never the less, the third question:
                >>>>Any other idea on this case? Better solution is
welcomed!

        I have to deal with this issue, and I also hope this will contribute
to the kernel, this will give very good support to players working on LINUX,
and also make the cdrom/dvdrom works much more reasonable (IMHO we can have
two types of read() on such device that may encounter real difficulty when
doing R/W, we can do more retry when data correctness is mostly concerned,
but we won't retry for ever.)

        Thanks for your help!

Regards


                Guangyu
