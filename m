Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTDID2Q (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTDID2Q (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:28:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbTDID2N (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 23:28:13 -0400
Message-ID: <32907.4.64.197.106.1049859540.squirrel@webmail.osdl.org>
Date: Tue, 8 Apr 2003 20:39:00 -0700 (PDT)
Subject: Re: readprofile: 0 total     nan (fwd)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <Shesha@asu.edu>
In-Reply-To: <Pine.GSO.4.21.0304081836190.25278-100000@general3.asu.edu>
References: <Pine.GSO.4.21.0304081836190.25278-100000@general3.asu.edu>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We were seeing this problem occasionally at OSDL (but not on Xscale :).
Is Xscale little or big endian?

I suggest that you try the proposed patch or just run readprofile
with the -n option.

Did you try either of those yet?

~Randy


> Hello All
>
> I am not very sure that it is readprofile application problem. I downloaded
> readprofile source and I compiled it. It worked fine on x86 machine running
> 2.4.7-10 kernel. I cross compiled it for xscale processor running 2.4.18 it
> is not working.
>
> Any Input?
>
>
> On Tue, 8 Apr 2003, Andy Pfiffer wrote:
>
>> On Tue, 2003-04-08 at 15:41, Shesha@asu.edu wrote:
>> > I am running 2.4.18 kernel for ARM. I have one of the boot parameters
>> "profile=2". The size of the /proc/profile file is shown as 16MB. But
>> when I execute "readprofile" the output is ...
>> > 0 total                                         nan
>> >
>> > If I cat the file it just give me a ".". Can anyone suggest what i am
>> doing wrong?
>>
>> [ I swear I was just talking about this problem with someone else... ]
>>
>> 1. /proc/profile is a binary file.  cat won't show you anything
>> meaningful.
>>
>> 2. the 0 output by readprofile is a problem with the automatic
>> byte-order detection heuristic built into the code.  Try invoking
>> readprofile with the "-n" option, and see if your problem goes away.
>>
>> FYI: For those that might also run into this, the essence of the problem
>> is this piece of code in readprofile.c (fragmented for clarity):
>>
>> "optNative" is 0.
>> "buf" is an unsigned int *.
>>
>>
>> if (!optNative) {
>>         int entries = len/sizeof(*buf);
>>         int big = 0,small = 0,i;
>>         unsigned *p;
>>
>>         for (p = buf+1; p < buf+entries; p++)
>>                 if (*p) {
>>                         if (*p >= 1 << (sizeof.7-10 kernel. I cross
compiled it for xscale processor running 2.4.18 it
> is not working.
>
> Any Input?
>
>
> On Tue, 8 Apr 2003, Andy Pfiffer wrote:
>
>> On Tue, 2003-04-08 at 15:41, Shesha@asu.edu wrote:
>> > I am running 2.4.18 kernel for ARM. I have one of the boot parameters
>> "profile=2". The size of the /proc/profile file is shown as 16MB. But
>> when I execute "readprofile" the output is ...
>> > 0 total                                         nan
>> >
>> > If I cat the file it just give me a ".". Can anyone suggest what i am
>> doing wrong?
>>
>> [ I swear I was just talking about this problem with someone else... ]
>>
>> 1. /proc/profile is a binary file.  cat won't show you anything
>> meaningful.
>>
>> 2. the 0 output by readprofile is a problem with the automatic
>> byte-order detection heuristic built into the code.  Try invoking
>> readprofile with the "-n" option, and see if your problem goes away.
>>
>> FYI: For those that might also run into this, the essence of the problem
>> is this piece of code in readprofile.c (fragmented for clarity):
>>
>> "optNative" is 0.
>> "buf" is an unsigned int *.
>>
>>
>> if (!optNative) {
>>         int entries = len/sizeof(*buf);
>>         int big = 0,small = 0,i;
>>         unsigned *p;
>>
>>         for (p = buf+1; p < buf+entries; p++)
>>                 if (*p) {
>>                         if (*p >= 1 << (sizeof(*buf)/2)) big++;
>>                         else small++;
>>                 }
>>         if (big > small) {
>>                 fprintf(stderr,"Assuming reversed byte order. "
>>                    "Use -n to force native byte order.\n");
>>                 <snipped>
>>                 .
>>                 .
>>                 .
>>         }
>> }
>>
>> Based on my read of the code, "big" will be incremented if *p >= 4,
>> otherwise "small" will be incremented.  I can't see how this would ever
>> detect the byte order...
>>
>> Werner proposed this as a solution, but it could still fail to correctly
>> detect the byteorder (although with much less frequency):



