Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132597AbRAPU3i>; Tue, 16 Jan 2001 15:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRAPU32>; Tue, 16 Jan 2001 15:29:28 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132637AbRAPU3Y>;
	Tue, 16 Jan 2001 15:29:24 -0500
Message-ID: <20010116121845.A3172@bug.ucw.cz>
Date: Tue, 16 Jan 2001 12:18:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Keith Owens <kaos@ocs.com.au>, Werner Puschitz <werner.lx@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion 8290 HANGS on boot 2.4/2.4-test9
In-Reply-To: <Pine.LNX.4.21.0101131608320.1168-100000@localhost.localdomain> <12064.979432308@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <12064.979432308@ocs3.ocs-net>; from Keith Owens on Sun, Jan 14, 2001 at 11:31:48AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Is there a safe way to add debug information like simple string prints in
> >arch/i386/boot/compressed/head.s and in arch/i386/kernel/head.S
> >so that I can see at the console where the boot process hangs?
> 
> Time for another version of my VIDEO_CHAR patch.]

What abourt early_printk? Works well on x86-64... And you can easily
redirect printk to early_printk.

#include <asm/io.h>


#ifndef MINIKERNEL
#define VGABASE		0xffffffff800b8000ul	/* This is "wrong" address to access it, we should access it using 0xffff8000000b8000ul; but 0xffff8000000b8000ul is not available early at boot. */
#else
#define VGABASE		0xb8000ul
#endif

#define MAX_YPOS	25
#define MAX_XPOS	80

static int current_ypos = 1, current_xpos = 0; /* We want to print before clearing BSS */
int printk_ready = 0;

#ifndef MINIKERNEL
void
early_clear (void)
{
	int k, i;
	for(k = 0; k < MAX_YPOS; k++)
		for(i = 0; i < MAX_XPOS; i++)
			writew(0, VGABASE + 2*(MAX_XPOS*k + i));
	current_ypos = 0;
}

void
early_puts (const char *str)
{
	char c;
	int  i, k, j;

	while ((c = *str++) != '\0') {
		if (current_ypos >= MAX_YPOS) {
#ifndef CONFIG_SIMNOW
			/* scroll 1 line up */
			for(k = 1, j = 0; k < MAX_YPOS; k++, j++) {
				for(i = 0; i < MAX_XPOS; i++) {
					writew(readw(VGABASE + 2*(MAX_XPOS*k + i)),
					       VGABASE + 2*(MAX_XPOS*j + i));
				}
			}
			for(i = 0; i < MAX_XPOS; i++) {
				writew(0x720, VGABASE + 2*(MAX_XPOS*j + i));
			}
			current_ypos = MAX_YPOS-1;
#else
			/* MUCH faster */
			early_clear();
			current_ypos = 0;
#endif
		}
		if (c == '\n') {
			current_xpos = 0;
			current_ypos++;
		} else if (c != '\r')  {
			writew(((0x7 << 8) | (unsigned short) c),
			       VGABASE + 2*(MAX_XPOS*current_ypos + current_xpos++));
			if (current_xpos >= MAX_XPOS) {
				current_xpos = 0;
				current_ypos++;
			}
		}
	}
}
#else
#define putc(c, x) writew(((0x7 << 8) | (unsigned short) (c)), \
			  VGABASE + (x) * 2);

void
early_puts (const char *str)
{
	char c;
	int  i, rest;

	while ((c = *str++) != '\0') {
		if (c == '\n' || c == '\r') {
			/* blank rest of the line */
			rest = MAX_XPOS - (current_xpos % MAX_XPOS);
			for (i=0; i < rest; i++) {
				putc(' ', current_xpos++);
			}
		} else {
			putc(c, current_xpos);
			current_xpos++;
		}
		current_xpos %= MAX_XPOS * MAX_YPOS;
	}
}
#endif /* MINIKERNEL */

static char buf[1024];

int early_printk(const char *fmt, ...)
{
	va_list args;
	int i;

	va_start(args, fmt);
	i = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf)-4 */
	va_end(args);

	if (!printk_ready)
		early_puts(buf);
	else
		printk("%s", buf);

	return i;
}

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
