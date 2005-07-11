Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVGKNkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVGKNkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGKNkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:40:23 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:62922 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261694AbVGKNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:39:21 -0400
Message-ID: <42D27682.4080201@torque.net>
Date: Mon, 11 Jul 2005 09:39:14 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Aaron VonderHaar <gruen0aermel@gmail.com>, paranoia@xiph.orgl,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [Paranoia] program cdparanoia not setting count and/or reply_len
 properly
References: <f4cf9e34050704022158f5e779@mail.gmail.com> <42CD3432.2090901@tmr.com>
In-Reply-To: <42CD3432.2090901@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Aaron VonderHaar wrote:
> 
>> When ripping from a scsi device (/dev/sg*) with linux kernel 2.6.11,
>> my kernel log is filled with messages like
>>
>> === dmesg ===
>> sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing data 
>> in;
>>   program cdparanoia not setting count and/or reply_len properly
>> printk: 40 messages suppressed.
>> sg_write: data in/out 30576/30576 bytes for SCSI command 
>> 0xbe--guessing data in;
>>   program cdparanoia not setting count and/or reply_len properly
>> printk: 128 messages suppressed.
>> sg_write: data in/out 30576/30576 bytes for SCSI command 
>> 0xbe--guessing data in;
>>   program cdparanoia not setting count and/or reply_len properly
>> printk: 149 messages suppressed.
>> sg_write: data in/out 16464/16464 bytes for SCSI command 
>> 0xbe--guessing data in;
>>   program cdparanoia not setting count and/or reply_len properly
>> printk: 153 messages suppressed.
>> sg_write: data in/out 30576/30576 bytes for SCSI command 
>> 0xbe--guessing data in;
>>   program cdparanoia not setting count and/or reply_len properly
>> printk: 153 messages suppressed.
>> === END ===
>>
>> After taking a hard look at the cdparanoia code handle_scsi_cmd(), and
>> the kernel sg driver, I've found the problem is this bit of code in
>> the kernel,
>>
>> === linux/drivers/scsi/sg.c LINE 566 ===
>>        /*
>>         * SG_DXFER_TO_FROM_DEV is functionally equivalent to 
>> SG_DXFER_FROM_DEV,
>>         * but is is possible that the app intended SG_DXFER_TO_DEV,
>> because there
>>         * is a non-zero input_size, so emit a warning.
>>         */
>>        if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV)
>>                if (printk_ratelimit())
>>                        printk(KERN_WARNING
>>                               "sg_write: data in/out %d/%d bytes for
>> SCSI command 0x%x--"
>>                               "guessing data in;\n" KERN_WARNING "   "
>>                               "program %s not setting count and/or
>> reply_len properly\n",
>>                               old_hdr.reply_len - (int)SZ_SG_HEADER,
>>                               input_size, (unsigned int) cmnd[0],
>>                               current->comm);
>> === END ===
>>
>> As I said, this is in kernel 2.6.11.  I noticed that this piece of
>> code is absent from 2.6.9, so is presumably a new error-checking
>> addition, which unfortunately breaks cdparanoia (the following comment
>> seems to explain why cdparanoia must set the count "incorrectly"),
>>
>> === cdparanoia-III-alpha9.8/interface/scsi_interface.c LINE 130 ===
>>  /* The following is one of the scariest hacks I've ever had to use.
>>     The idea is this: We want to know if a command fails.  The
>>     generic scsi driver (as of now) won't tell us; it hands back the
>>     uninitialized contents of the preallocated kernel buffer.  We
>>     force this buffer to a known value via another bug (nonzero data
>>     length for a command that doesn't take data) such that we can
>>     tell if the command failed.  Scared yet? */
>> === END ===
>>
>> With this new warning being logged for nearly every SCSI command
>> (hundreds of times per second), my system becomes unresponsive and
>> ripping is considerably slowed.
>>
>> If I remove the warning code from the kernel and recompile it, ripping
>> seems to proceed as normal.
>>
>> I'm not sure what ought to be done about this, but I though I should
>> at least record my hours' worth of bewilderment for the next person
>> who googles this error message.
>>
> 
> Alan Cox has sent fixes for some of the problems in sg to one of the 
> maintainers, but they don't seem to be in mainline. Perhaps he could 
> send them to akpm and see if he is interested in fixing problems. Once 
> the problem with error reporting is fixed (and that may not be the fix 
> Alan has devised) by someone then paranoia can get rid of the egregious 
> hack.

Bill,
If I have received any patches from Alan Cox on this
matter, then I have forgotten/misplaced them.

The change that upset cdparanoia dates from a thread
on this list (lsml) titled:
"[PATCH] sg.c to set direction more reliably ..."
from last year proposed by Jeremy Higdon, see:
http://marc.theaimsgroup.com/?l=linux-scsi&m=109350427728262&w=2

I'm surprised that cdparanoia is still using the sg
version 2 (or 1) interface, that comment is relevant
prior to lk 2.4.0 (and that problem could be worked
around from lk 2.2.6 which dates from 1998).
Perhaps it is an old version of cdparanoia.

> I've expanded the recipients list, perhaps we'll get a status on (a) if 
> the fix Alan has will cause correct error reporting, and (b) when it can 
> be put in mainline. The paranoia can clean up its act.

Anyway, that "printk_ratelimit()" could be replaced
by a static so that the message is output once per
kernel lifetime. The SG_IO block layer passthrough does
something like this for commands that it doesn't understand.
Even that causes email queries to me ... "how come
the kernel reports LOG SENSE as an unknown opcode".
At least this single log warning doesn't break any
apps that I am aware of.

Doug Gilbert



