Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVKCQi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVKCQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVKCQi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:38:56 -0500
Received: from spirit.analogic.com ([204.178.40.4]:62986 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030379AbVKCQiz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:38:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051103160123.GI28038@flint.arm.linux.org.uk>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk> <20051103095725.GA703@openzaurus.ucw.cz> <20051103144904.GG28038@flint.arm.linux.org.uk> <20051103153445.GA3530@ucw.cz> <20051103160123.GI28038@flint.arm.linux.org.uk>
X-OriginalArrivalTime: 03 Nov 2005 16:38:54.0142 (UTC) FILETIME=[14124DE0:01C5E095]
Content-class: urn:content-classes:message
Subject: Re: best way to handle LEDs
Date: Thu, 3 Nov 2005 11:38:53 -0500
Message-ID: <Pine.LNX.4.61.0511031135160.26288@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: best way to handle LEDs
Thread-Index: AcXglRQbuIugi2yuSXWvXoulzVYAIA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>,
       "John Lenz" <lenz@cs.wisc.edu>, "Robert Schwebel" <robert@schwebel.de>,
       "Robert Schwebel" <r.schwebel@pengutronix.de>, <rpurdie@rpsys.net>,
       "kernel list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Nov 2005, Russell King wrote:

> On Thu, Nov 03, 2005 at 04:34:45PM +0100, Vojtech Pavlik wrote:
>> On Thu, Nov 03, 2005 at 02:49:04PM +0000, Russell King wrote:
>>> On Thu, Nov 03, 2005 at 10:57:26AM +0100, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>> Except the led code that is being proposed CAN sit on top of a generic
>>>>>> GPIO layer.
>>>>>
>>>>> I also have issues with a generic GPIO layer.  As I mentioned in the
>>>>> past, there's serious locking issues with any generic abstraction of
>>>>> GPIOs.
>>>>>
>>>>> 1. You want to be able to change GPIO state from interrupts.  This
>>>>>    implies you can not sleep in GPIO state changing functions.
>>>>>
>>>>> 2. Some GPIOs are implemented on I2C devices.  This means that to
>>>>>    change state, you must sleep.
>>>>
>>>> Can't you just busywait? Yes, it is ugly in general, but perhaps it
>>>> is better than alternatives...
>>>
>>> Does the i2c layer support busy waiting or are you suggesting something
>>> else?
>>
>> It usually doesn't support anything else. At least on the controllers
>> I've seen the drivers for.
>
> I think you misunderstand me.  Please read:
>
>  http://dictionary.reference.com/search?q=busywait
>
> Since the i2c transfer functions allow drivers to sleep (and some do)
> you can't "just busywait" without modifying the i2c layer to tell
> drivers to busy wait instead of sleeping.
>
> --
> Russell King
> Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> maintainer of:  2.6 Serial core

The whole thing is pretty easy. The interrupt code just signals
a task to do whatever...

For example:

Interrupt service routine or anything else, sets the
value in 'what' and 'which'. It then executes
(in demo code)  wake_up_interruptible(info->twait);
... and coutinues whatever it was doing. The daemon wakes
up (whenever) and, in process-context does whatever was
you wanted it to do.

extern void turn_led_on(int led);  // Can sleep
extern void turn_len_off(int len); // Can sleep

enum WHAT {
    TURN_LED_ON,
    TURN_LED_OFF,
    FLASH_LED,
    STOP_FLASH };

static WHAT what;
static int which;

static int local_kernel_thread(void *unused) {
     daemonize(name);
     for(;;) {
         set_current_state(TASK_INTERRUPTIBLE);
         if(signal_pending(current))
             complete_and_exit(&info->quit, 0);
         interruptible_sleep_on(&info->twait);
         set_current_state(TASK_RUNNING);
         preempt_disable();   // So we get this done soon
         switch(what) {
         case TURN_LED_ON:
             turn_led_on(which);
             break;
        case TURN_LEN_OFF:
             turn_led_off(which);
             break;
        case FLASH_LED:
            start_timer_queue_for_flashing_led(which); // Can sleep
            break;
        case STOP_FLASH:
            stop_timer_queue_for_flashing_led(which); // Can sleep
            break;
        default:
            printk("Brain fart\n");
        }
        preempt_enable();
     }
     return 0;
}


You never want to busy-wait for some "bells and whistles". You
just make a bells-and-whistles kernel daemon that does whatever
you want.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
