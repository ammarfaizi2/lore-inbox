Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQKXQyT>; Fri, 24 Nov 2000 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129716AbQKXQyK>; Fri, 24 Nov 2000 11:54:10 -0500
Received: from acl.lanl.gov ([128.165.147.1]:24885 "EHLO acl.lanl.gov")
        by vger.kernel.org with ESMTP id <S129257AbQKXQx4>;
        Fri, 24 Nov 2000 11:53:56 -0500
Date: Fri, 24 Nov 2000 09:23:55 -0700 (MST)
From: Ronald G Minnich <rminnich@lanl.gov>
To: Joan Bertran <jbertran@cirsa.com>
cc: "'Jon Burgess'" <Jon_Burgess@eur.3com.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting AMD Elan520 without BIOS
In-Reply-To: <01C05636.8794C2F0@wsi_joan.UNIDESA_RD>
Message-ID: <Pine.LNX.4.21.0011240922350.17415-100000@mini.acl.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Joan Bertran wrote:

>  I think so, because I've read somewhere the kernel needs interrupts 
> configured, but as kernel configures i8259 I don't know what is necessary,
> the IDT with interrupt service routines ?, sommething special about the chipset ?

I put the following familiar-looking code at the head of linuxbios for
mainboards that need to boot 2.2.x. It should look familiar, except of
course this is 32-bit gas-compatible code. 


#define i8259delay jmp 1f ; 1:

        movb    $0x11,%al               /*! initialization sequence*/
        outb    %al,$0x20               /*! send it to 8259A-1*/
        i8259delay
        outb    %al,$0xA0               /*! and to 8259A-2*/
        i8259delay
        movb    $0x20,%al               /*! start of hardware int's
(0x20)*/
        outb    %al,$0x21
        i8259delay
        movb    $0x28,%al               /*! start of hardware int's 2
(0x28)*/
        outb    %al,$0xA1
        i8259delay
        movb    $0x04,%al               /*! 8259-1 is master*/
        outb    %al,$0x21
        i8259delay
        movb    $0x02,%al               /*! 8259-2 is slave*/
        outb    %al,$0xA1
        i8259delay
        movb    $0x01,%al               /*! 8086 mode for both*/
        outb    %al,$0x21
        i8259delay
        outb    %al,$0xA1
        i8259delay
        movb    $0xFF,%al               /*! mask off all interrupts for
now*/
        outb    %al,$0xA1
        i8259delay
        movb    $0xFB,%al               /*! mask all irq's but irq2
which*/
        outb    %al,$0x21               /*! is cascaded*/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
