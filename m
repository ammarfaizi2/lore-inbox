Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTANPJH>; Tue, 14 Jan 2003 10:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTANPJG>; Tue, 14 Jan 2003 10:09:06 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:43713 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S263342AbTANPJD>; Tue, 14 Jan 2003 10:09:03 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8F9@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: anyone have a 16-bit x86 early_printk?
Date: Tue, 14 Jan 2003 09:17:40 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can share our serial tool for debugging early boot. It is actually written
for IA64 by Chuck Sluder at Unisys, and we used it even for EFI driver
debug. It saved us a lot of grief.
You can modify it for IA32. It just outputs debug messages to the serial
port directly, so you will need a serial console:

This insertion is into kernel/prink.c:
---------------------------------------------
extern void writebuf(int, const char *);

void
early_printk (const char *str)
{
	char c;
	int  i, k, j;

#ifdef CONFIG_ITANIUM_ES7000
// this is out writing to serial port routine:
	writebuf(0, str);
#endif
	while ((c = *str++) != '\0') {




==cut here io.c =======================



#include <string.h>

extern unsigned long ia64_iobase;
extern void outb_asm();
extern unsigned char inb_asm();

unsigned short
serial_port_addr[4] = {
    0x3f8,
    0x2f8,
    0x3e8,
    0x2e8
};

void
outb(unsigned short port, unsigned char data)
{
	unsigned char *addr;
	
	addr = (unsigned char *)(ia64_iobase | ((port & 0xfffc) << 10) |
(port & 0x0fff));
	outb_asm(addr, data);
	
	return;
}

unsigned char
inb(unsigned short port)
{
	unsigned char *addr, data;

	addr = (unsigned char *)(ia64_iobase | ((port & 0xfffc) << 10) |
(port & 0x0fff));

	data = inb_asm(addr);
	
	return(data);
}


#define SERIAL_REGISTER_LSR 5    /*  R/W  Line Status Register */

void
mputc(unsigned char port, unsigned char data)
{
	unsigned char status, i=0;
	unsigned short portaddr;

	portaddr = serial_port_addr[port];

	do {
		status = inb((serial_port_addr[port] +
SERIAL_REGISTER_LSR));
		i++;
		if (i == 10000){
			return;
		}
	} while ((status & 0x20) == 0);

	outb(portaddr, data);	
	
	return;
}

int
writebuf(unsigned char port, char *buf)
{
	int i;
	size_t cnt;
	unsigned char data;

	
	cnt = strlen(buf);

	for (i=0; i<cnt; i++) {
		data = buf[i];
		if (data == '\n') {
			mputc(port, 0x0d);
			mputc(port, 0x0a);
		} else {
			mputc(port, data);
		}
	}

	return((int)cnt);
}


====sample asm inb and outb for IA64========

	.text

	.global inb_asm
	.global outb_asm
	.global read_psr
	.global read_iva
	.global read_xapic
	.global write_xapic

	.align 32



	.proc inb_asm
inb_asm:

        mf                      // fence all loads/stores
        ld1.acq r8 = [r32]      // read a byte from the port
        mf.a                    // make sure the platform accepts it

        br.ret.sptk     b0
	.endp inb_asm



	.proc outb_asm
outb_asm:

        st1.rel [r32] = r33     // write one byte to a port
        mf.a                    // make sure the platform accepts it
        mf                      // fence all loads/stores

        br.ret.sptk     b0

	.endp outb_asm
