Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276634AbRJPSwx>; Tue, 16 Oct 2001 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276639AbRJPSwo>; Tue, 16 Oct 2001 14:52:44 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:37042 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276634AbRJPSw3>; Tue, 16 Oct 2001 14:52:29 -0400
Date: Tue, 16 Oct 2001 11:46:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Keith Owens <kaos@ocs.com.au>, "P.Agenbag" <internet@psimation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: P4 problems 
Message-ID: <2505399235.1003232779@mbligh.des.sequent.com>
In-Reply-To: <23891.1003232529@ocs3.intra.ocs.com.au>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea is to write characters direct to the video screen during
> booting using a macro called VIDEO_CHAR.  This macro takes a character
> position and a single character value to be displayed.  Use different
> positions on the screen for different levels of code and use different
> characters in one position to indicate which stage that level is up to.
> For example, with the patch below, the string EAC at hang indicates
> parse_options(), checksetup().

I have a slightly more complex verson of this which does a whole printk,
and you can embed values, strings, etc. Same fundamental idea - ram
stuff directly into the video buffer. It's not pretty or portable, but then again,
it's for early debug only, so deal with it ;-) We really ought to make 
everything before console_init use early_printk, which would be #defined
to printk by default, and this on x86. Maybe. One day. Maybe ;-)

Disclaimer: I tried this on 2.4.12 the other day, and didn't get it working
in the 2 minutes I spent before guessing what the problem was. But it
worked beautifully on 2.4.0-test8, which was last time I used it. Should
work fine though .... it's pretty simple. It's not a patch style, it's a .c
file that I just #include whereever I'm working (because I'm an evil
dirty hacker). Feel free to make it prettier if anyone feels so inclined.

Bits of code shamelessly stolen from the bootstrap stuff.

/* Martin J. Bligh <Martin.Bligh@us.ibm.com> */ 
/* Bits of code shamelessly stolen from the bootstrap stuff. */


#define VIDMEMBUF 0xB800 


int orig_x = 0; 
int orig_y = 0; 
int vidport = 0x3d4; 


void early_scroll(void) 
{ 
	int i, cols = 80, lines = 25; 
	unsigned char *vidmem = phys_to_virt(VIDMEMBUF); 


	memcpy ( vidmem, vidmem + cols * 2, ( lines - 1 ) * cols * 2 ); 
	for ( i = ( lines - 1 ) * cols * 2; i < lines * cols * 2; i += 2 ) 
		vidmem[i] = ' '; 
} 


void clearvidmem(void) 
{ 
	int x, y, pos = 0; 
	unsigned char *vidmem = phys_to_virt(VIDMEMBUF); 


	for (x = 0; x < 80; x++) { 
		for (y = 0; y < 25; y++) { 
			vidmem [ ( x + 80 * y ) * 2 ] = ' '; 
		} 
	} 
	orig_x = 0; 
	orig_y = 0; 


	/* Update cursor position */ 
	outb_p(14, vidport); 
	outb_p(0xff & (pos >> 9), vidport+1); 
	outb_p(15, vidport); 
	outb_p(0xff & (pos >> 1), vidport+1); 
} 


void pokevidmem(int x, int y, char c) 
{ 
	unsigned char *vidmem = phys_to_virt(VIDMEMBUF); 


	vidmem [ ( x + 80 * y ) * 2 ] = c; 
} 


void spin_on_me(int howlong) 
{ 
	int i, j; 


	for (i=0; i<howlong; ++i) 
		for (j=0; j<10000; ++j) /* spin 1 sec */ 
			udelay(100); 
} 


void early_puts(const char *s) 
{ 
	int x,y,pos, cols = 80, lines = 25; 
	char c; 


	x = orig_x; 
	y = orig_y; 


	while ( ( c = *s++ ) != '\0' ) { 
		if ( c == '\n' ) { 
			x = 0; 
			if ( ++y >= lines ) { 
				early_scroll(); 
				y--; 
			} 
		} else { 
			pokevidmem (x, y, c); 
			if ( ++x >= cols ) { 
				x = 0; 
				if ( ++y >= lines ) { 
					early_scroll(); 
					y--; 
				} 
			} 
		} 
	} 


	orig_x = x; 
	orig_y = y; 


	pos = (x + cols * y) * 2; /* Update cursor position */ 
	outb_p(14, vidport); 
	outb_p(0xff & (pos >> 9), vidport+1); 
	outb_p(15, vidport); 
	outb_p(0xff & (pos >> 1), vidport+1); 
} 


void early_printk(const char *fmt, ...) 
{ 
	va_list args; 
	int i; 
	char buf[1024]; 


	va_start(args, fmt); 
	i = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf)-4 */ 
	va_end(args); 
	early_puts(buf); 
	printk(buf); 
} 


