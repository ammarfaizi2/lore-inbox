Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHaQkW>; Fri, 31 Aug 2001 12:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbRHaQkD>; Fri, 31 Aug 2001 12:40:03 -0400
Received: from ariel.xerox.com ([208.140.33.25]:59277 "EHLO
	ariel.eastgw.xerox.com") by vger.kernel.org with ESMTP
	id <S268071AbRHaQjw>; Fri, 31 Aug 2001 12:39:52 -0400
Message-Id: <200108311640.MAA00467@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
Subject: looping on a single timing event
Date: Fri, 31 Aug 2001 12:40:08 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing a device driver.  Its for a proprietary serial interface
I'm using 2.4.5.

It seems something is going south, and I go into ack_timeout nonstop
(even though I added ONE event with a timer).

    665 static void ack_timeout(unsigned long ptr)
    666 {
    667         my_printk("ack timeout\n");
    668         if(xmit_retries < 3) {
    669                 if(!current_xmitting_packet) {
    670                         my_printk("resending packet\n");
    671                         xmit_bytes_sent = 0;
    672                         xmit_state = SENDING_MSG;
    673                         current_xmitting_packet = xmit_messages;         
    674                         kis_continue_output();
    675                         xmit_retries++;
    676                 } else {
    677                         my_printk("currently sending packet\n");
    678                 }
    679         } else {
    680                 my_printk("retranxmits up");
    681                 send_nack(0x80);        /* guess */
    682                 remove_head_xmit_message();
    683         }
    684 
    685 }
    686 
    687 static void setup_ack_timer(void)
    688 {
    689         init_timer(&ack_timer);
    690         ack_timer.function = ack_timeout;
    691         ack_timer.expires = jiffies + (HZ/25);
    692         ack_timer.data = NULL;
    693         add_timer(&ack_timer);
    694         my_printk("added ack timer\n");
    695 }
    696 


my_printk is a macro allowing me to see the time:
# define my_printk(args...) { kis_show_time();  printk(##args); }

The code at line 687 isn't executing.
I'm seeing a continious
	ack timeout (line 667)
	currently sending packet (line 677)

I also don't have console control.

ack_timeout is only called via the ack_timer.function.

(Of course, when I log more things, the timing changes and I don't
have a problem (but others things don't work with my hardware interface).

Any hints for getting console control back when this starts happening?
Or logging in a non-time-destructive way?

marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
