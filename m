Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUIUTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUIUTfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUIUTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:35:46 -0400
Received: from c-24-19-11-70.client.comcast.net ([24.19.11.70]:26580 "EHLO
	ultimation.org") by vger.kernel.org with ESMTP id S268021AbUIUTfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:35:37 -0400
Message-ID: <16359.69.25.132.5.1095795335.squirrel@69.25.132.5>
In-Reply-To: <20040921190710.GA4237@ucw.cz>
References: <12361.69.25.132.5.1095791755.squirrel@69.25.132.5>
    <20040921190710.GA4237@ucw.cz>
Date: Tue, 21 Sep 2004 12:35:35 -0700 (PDT)
Subject: Re: [PATCH] Support for Snapstream Firefly remote added to 
     ati_remote.c
From: dylan@ultimation.org
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: dylan@ultimation.org, greg@kroah.com, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Sep 21, 2004 at 11:35:55AM -0700, dylan@ultimation.org wrote:
>
>> I've added support for the Snapstream Firefly X10 remote
>> (http://www.snapstream.com/Products/firefly/). This involved adding a
>> new
>> product ID, and adding some additional logic to the event_lookup
>> function.
>> The Firefly alternately encodes the keypress data differently than the
>> driver currently expects, so that every other keypress is invalid with
>> the
>> current driver version. The transformation is pretty simple; I'm
>> assuming
>> it's there simply to allow the driver to distinguish between what two
>> distinct key events looks like and what it looks like to drop signal in
>> the middle of holding a remote button.
>>
>> As well, I also added a module_param called disable_keyboard which
>> allows
>> the user to toggle off whether the driver actually sends key events, or
>> simply generates raw evdev events. I found this useful, since I'm
>> working
>> on an app that reads the evdev events natively and then sends it's own
>> keyboard/mouse/window events in X. The keyboard events being sent by the
>> driver were interfering with the events I wanted to generate myself.
>>
>> This patch applies to version 2.6.9-rc1-mm4.
>>
>> Signed-off-by: Dylan Paris <kernelcontrib@ultimation.org>
>>
>> @@ -280,6 +289,9 @@ static struct
>>         {KIND_FILTERED, 0xf4, 0x2F, EV_KEY, KEY_END, 1},        /* END
>> */
>>         {KIND_FILTERED, 0xf5, 0x30, EV_KEY, KEY_SELECT, 1},     /*
>> SELECT */
>>
>> +       /* Firefly Remote Buttons */
>> +       {KIND_FILTERED, 0xf1, 0x2c, EV_KEY, KEY_KATAKANA, 1},     /*
>> MAXIMIZE */
>> +
>
> Now, now, would it be too hard to add a proper key definition into
> input.h? I don't think you want the remote to change character sets on
> Japanese machines.
>

Will do.

>> @@ -460,6 +479,7 @@ static void ati_remote_input_report(stru
>>         struct input_dev *dev = &ati_remote->idev;
>>         int index, acc;
>>         int remote_num;
>> +       int ev_type;
>>
>>         /* Deal with strange looking inputs */
>>         if ( (urb->actual_length != 4) || (data[0] != 0x14) ||
>> @@ -492,7 +512,9 @@ static void ati_remote_input_report(stru
>>
>>         if (ati_remote_tbl[index].kind == KIND_LITERAL) {
>>                 input_regs(dev, regs);
>> -               input_event(dev, ati_remote_tbl[index].type,
>> +
>> +               ev_type = ((disable_keyboard) ? 0 : >
>> ati_remote_tbl[index].type);
>> +               input_event(dev, ev_type,
>>                         ati_remote_tbl[index].code,
>>                         ati_remote_tbl[index].value);
>>                 input_sync(dev);
>
> I won't let you abuse the input API this way. Event type 0 is EV_SYN and
> is reserved for synchronization and configuration change notifications.
> Definitely not for sending events that look like keystrokes but aren't.
>
> There is a nice ioctl, called EVIOCGRAB which will give you what you
> want (the console won't be receiving the events anymore) without any
> ugly hacks.
>

Sorry for the hacks, I'm still learning about how this all works. I was
just excited that I was able to get it "work" at all, even if it was
really ugly. ;)  I'll look into EVIOCGRAB and touch up the patch before
thinking about resubmitting again. Thanks for the input!

> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR
>


