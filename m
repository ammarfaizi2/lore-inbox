Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312461AbSCaVTS>; Sun, 31 Mar 2002 16:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSCaVTL>; Sun, 31 Mar 2002 16:19:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60348 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312461AbSCaVS5>;
	Sun, 31 Mar 2002 16:18:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 31 Mar 2002 21:18:56 GMT
Message-Id: <UTC200203312118.VAA468180.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: kbdbook.tmpl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spent the past hour or two documenting the keyboard ioctls.
For the result, see below (and on ftp.xx.kernel.org).
Comments are welcome, both about the factual contents
and about the style and layout. The idea is to eventually
have all ioctls documented.

Andries

----------kbdbook.tmpl-------------
<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>

<book id="KeyboardGuide">
 <bookinfo>
   <title>Keyboard Programming Interface</title>

   <authorgroup>
    <author>
     <firstname>Andries</firstname>
     <surname>Brouwer</surname>
     <affiliation>
      <address>
       <email>aeb@cwi.nl</email>
      </address>
     </affiliation>
    </author>
   </authorgroup>

   <copyright>
    <year>2002</year>
    <holder>Andries Brouwer</holder>
   </copyright>

  <legalnotice>
   <para>
     This documentation is free software; you can redistribute
     it and/or modify it under the terms of the GNU General Public
     License as published by the Free Software Foundation; either
     version 2 of the License, or (at your option) any later
     version.
   </para>
      
   <para>
     This program is distributed in the hope that it will be
     useful, but WITHOUT ANY WARRANTY; without even the implied
     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
     See the GNU General Public License for more details.
   </para>
      
   <para>
     You should have received a copy of the GNU General Public
     License along with this program; if not, write to the Free
     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
     MA 02111-1307 USA
   </para>
      
   <para>
     For more details see the file COPYING in the source
     distribution of Linux.
   </para>
  </legalnotice>
 </bookinfo>

<toc></toc>

  <chapter id="KeyboardAPI">
   <title>Keyboard API</title>

   <para>
	This document describes the user interface to the
	kernel keyboard driver.
   </para>

   <sect1 id="KeyboardType">
    <title>The keyboard type</title>
    <para>
    <programlisting>
	unsigned char kbtype;
	ioctl(fd, KDGKBTYPE, &amp;kbtype); /* get keyboard type */
    </programlisting>
    </para>

    <para>
	The <constant>KDGKBTYPE</constant> ioctl returns the keyboard type
	in the unsigned char <varname>kbtype</varname>.
    </para>

    <para>
	This ioctl is fairly useless.
	It returns the value of the kernel variable
	<varname>keyboard_type</varname>, which defaults to
	<constant>KB_101</constant> but is set to
	<constant>KB_84</constant> in the Atari code.
	There is no real attempt in the kernel to determine and return
	the actual type of keyboard.
    </para>

    <para>
	The main use of this ioctl is to test the validity of the
	<varname>fd</varname> argument. When user space needs a
	file descriptor for doing keyboard or console ioctl's
	it might try file descriptors 0, 1, 2, or files like
	<filename>/dev/tty</filename> or <filename>/dev/console</filename>.
	The file descriptor is OK when the <constant>KDGKBTYPE</constant>
	ioctl succeeds:
	<programlisting>
#include &lt;sys/ioctl.h&gt;
#include &lt;linux/kd.h&gt;
static int
is_a_console(int fd) {
    unsigned char arg;

    arg = 0;
    return (ioctl(fd, KDGKBTYPE, &amp;arg) == 0
            &amp;&amp; (arg == KB_101 || arg == KB_84));
}
	</programlisting>
    </para>
   </sect1>

   <sect1 id="KeyboardModes">
    <title>The keyboard modes</title>
    <para>
    <programlisting>
	int kbmode;
	ioctl(fd, KDGKBMODE, &amp;kbmode); /* get keyboard mode */
	ioctl(fd, KDSKBMODE, kbmode);  /* set keyboard mode */
    </programlisting>
    </para>

    <para>
	The keyboard can be in three modes: <constant>K_RAW</constant>,
	where scancodes are transmitted directly to user space (or, rather,
	to the tty line discipline), <constant>K_MEDIUMRAW</constant>,
	where scancodes are converted to keycodes, and these are transmitted
	to user space, and "cooked", where scancodes are converted to keycodes
	and keycodes are converted to keysyms using the user's keymap.
	This "cooked" mode comes in two flavours: <constant>K_XLATE</constant>,
	which is the default, and <constant>K_UNICODE</constant> (see below).
    </para>

    <note>
     <para>
	Do not confuse the "raw" and "cooked" here with the "raw" and "cooked"
	of the tty line discipline, as set, e.g., by stty(1).
     </para>
    </note>
   </sect1>

   <sect1 id="KeyboardKeycodes">
    <title>The keyboard keycodes</title>
    <para>
    <programlisting>
	struct kbkeycode a;
	ioctl(fd, KDGETKEYCODE, &amp;a); /* get keycode */
	ioctl(fd, KDSETKEYCODE, &amp;a); /* set keycode */
    </programlisting>
    </para>

    <para>
	Scancodes are produced by the hardware.
	Keycodes are used by the user in their keymap.
	The usual PC keyboard, in the default mode, returns
	a sequence of scancodes for each key press and key release.
	The kernel parses the sequence into the keycode.
    </para>

    <para>
	The keycode is a single byte, of which the high order bit
	is used to indicate press(0)/release(1). The value 0 is used
	for special purposes. So, 127 keycodes are available to
	identify the keyboard keys. Usually this suffices, but not always.
    </para>

    <para>
	The correspondence between scancode sequence and keycode
	is hardwired to be the identity for single scancodes in the range
	1-88 (0x01-0x58). For the remaining single scancodes
	(0x59-0x7f) or scancode pairs (sequences of length two:
	0xe0 0x00 - 0xe0 0x7f), a corresponding keycode can be assigned
	(in the range 1-127).
	<programlisting>
	struct kbkeycode a;
	a.scancode = 0x59; /* for single scancode 59 (hex) */
	a.scancode += 128; /* for scancode pair e0 59 (hex) */
	a.keycode = 123;
	ioctl(fd,KDSETKEYCODE,&amp;a);
	</programlisting>
	See also getkeycodes(8) and setkeycodes(8).
    </para>

    <note>
     <para>
	Keycode 0 cannot be used: the value 0 is used to control
	allocation and deallocation of keymaps. For some architectures
	the setup is broken.
     </para>
    </note>
   </sect1>

   <sect1 id="KeyboardKeymap">
    <title>The keyboard keymap</title>
    <para>
	<programlisting>
	struct kbentry ke;
	ioctl(fd, KDGKBENT, &amp;ke);    /* get keyboard keymap entry */
	ioctl(fd, KDSKBENT, &amp;ke);    /* set keyboard keymap entry */

	struct kbsentry sbuf;
	ioctl(fd, KDGKBSENT, &amp;sbuf); /* get keyboard string entry */
	ioctl(fd, KDSKBSENT, &amp;sbuf); /* set keyboard string entry */

	struct kbdiacrs kd;
	ioctl(fd, KDGKBDIACR, &amp;kd);  /* get keyboard compose pair */
	ioctl(fd, KDSKBDIACR, &amp;kd);  /* set keyboard compose pair */

	char meta;
	ioctl(0, KDGKBMETA, &amp;meta;   /* get meta treatment */
	ioctl(0, KDSKBMETA, meta;    /* set meta treatment */
	</programlisting>
    </para>

    <para>
	The user's keymap indicates the correspondence between
	keycodes and symbols or actions belonging to these keys.
	<programlisting>
	alt_is_meta
	keycode 1 = Escape
	...
	control alt keycode 83 = Boot
	...
	alt keycode 103 = KeyboardSignal
	...
	string F1 = "\033[[A"
	...
	compose '`' 'A' to 'À'
	...
	</programlisting>
    </para>

    <para>
	Ordinary entries of the keymap are set using the
	<constant>KDSKBENT</constant> ioctl:
	<programlisting>
	struct kbentry ke;
	ke.kb_table = table_number;
	ke.kb_index = keycode;
	ke.kb_value = resulting_value;
	ioctl(fd, KDSKBENT, &amp;ke);
	</programlisting>
    </para>

    <para>
	Here there are 256 possible table numbers, corresponding
	to the simultaneous position of 8 shift keys
	(0: plain map, 1: shift, 2: altgr, 3: shift altgr,
	4: control, 5: shift control, ...) where these 8 shift keys
	are conventionally called 1: shift, 2: altgr, 4: control,
	8: alt, 16: shiftl, 32: shiftr, 64: ctrll, 128: ctrlr.
	Tables are dynamically allocated as needed, and deallocated
	by using keycode 0 with value <constant>K_NOSUCHMAP</constant>.
    </para>

    <para>
	The <varname>resulting_value</varname> variable is
	a 16-bit value. Its interpretation depends on the keyboard mode.
	In <constant>K_UNICODE</constant> mode it is a 16-bit Unicode
	value. In <constant>K_XLATE</constant> mode it is an 8-bit
	type field followed by an 8-bit value.
	See also keymaps(5), dumpkeys(1), loadkeys(1).
    </para>

    <para>
	String entries of the keymap are set using the
	<constant>KDSKBSENT</constant> ioctl:
	<programlisting>
	struct kbsentry sbuf;
	sbuf.kb_func = function_key_number;
	strncpy(sbuf.kb_string, "my string", 512);
	ioctl(fd, KDSKBSENT, &amp;sbuf);
	</programlisting>
    </para>

    <para>
	Compose combinations are set using the
	<constant>KDSKBDIACR</constant> ioctl:
	<programlisting>
	struct kbdiacrs kd;
	int accent_table_size;
	if (accent_table_size > MAX_DIACR)
		accent_table_size = MAX_DIACR;
	for (i = 0; i < accent_table_size; i++) {
		kd.kbdiacr[i].diacr = diacritic[i];
		kd.kbdiacr[i].base = base_symbol[i];
		kd.kbdiacr[i].result = combined_symbol[i];
	}
	kd.kb_cnt = accent_table_size;
	ioctl(fd, KDSKBDIACR, &amp;kd);
	</programlisting>
    </para>

    <para>
	As mentioned already, in <constant>K_XLATE</constant> mode
	a keymap entry consists of an 8-bit type field followed by
	an 8-bit value. If the type is <constant>KT_META</constant>,
	then there are two possible treatments, depending on the
	metamode setting of the VC. The possible settings are
	<constant>K_METABIT</constant> and <constant>K_ESCPREFIX</constant>.
	In the former mode the meta request causes setting of the
	high order bit of the value. In the latter it produces an
	ESC prefix.
	<programlisting>
	char meta = esc ? K_ESCPREFIX : K_METABIT;
	ioctl(fd, KDSKBMETA, meta);
	</programlisting>
    </para>
   </sect1>

   <sect1 id="KeyboardLEDAPI">
    <title>The keyboard LEDs</title>
    <para>
	<programlisting>
	char leds;
	ioctl(fd, KDGETLED, &amp;leds); /* get keyboard led settings */
	ioctl(fd, KDSETLED, leds);  /* set keyboard led settings */

#ifdef __sparc__
	/* Special Sun version */
	ioctl(fd, KIOCGLED, &amp;leds); /* get keyboard led settings */
	ioctl(fd, KIOCSLED, leds);  /* set keyboard led settings */
#endif

	char flags;
	ioctl(fd, KDGKBLED, &amp;flags); /* get keyboard flags */
	ioctl(fd, KDSKBLED, flags);  /* set keyboard flags */
	</programlisting>
    </para>

    <para>
	Most keyboards have three or four LEDs, normally indicating
	NumLock, CapsLock, ScrollLock and perhaps Compose or so.
	The default situation is that the LEDs indicate these
	keyboard flags (for the current foreground console).
	This is the <constant>LED_SHOW_FLAGS</constant> mode.
	The <constant>KDSKBLED</constant> ioctl sets these keyboard flags
	(and the default flags that are used after a reset).
	<programlisting>
	/* Set CapsLock, as if the CapsLock key was hit. */
	int flags = LED_CAP;
	int default_flags = 0;
	ioctl(fd, KDSKBLED, (default_flags << 4) | flags);
	</programlisting>
    </para>

    <para>
	It is also possible to show arbitrary information
	(or nice patterns - "blinkenlights") in the LEDs.
	This is the <constant>LED_SHOW_IOCTL</constant> mode.
	We get into this mode by using <constant>KDSETLED</constant>
	with a value that is zero outside the last three bits,
	and get out of it again by using the value 0xff.
	<programlisting>
/* Blink LEDs - run on a text console */
#include &lt;sys/ioctl.h&gt;
#include &lt;linux/kd.h&gt;

main() {
        int leds = 0;

        while (1) {
                leds = 2*leds+1;
                if (leds & 8)
                        leds ^= 9;
                if (ioctl(0, KDSETLED, leds))
                        exit(1);        /* 0 is not a good fd */
                sleep(1);
        }
}
	</programlisting>
	See also setleds(1).
    </para>

    <para>
	On a Sun, this same effect is obtained using the ioctl
	<constant>KIOCSLED</constant> on a file descriptor
	obtained by opening <filename>/dev/kbd</filename>.
    </para>

    <para>
	The third and last LED mode is LED_SHOW_MEM, where the
	LEDs show the contents of three specified bits in kernel memory.
	See the routine <function>register_leds()</function>
	in <filename>keyboard.c</filename>.
    </para>
	
   </sect1>

   <sect1 id="KeyboardRepeatRate">
    <title>The keyboard repeat rate</title>
    <para>
	<programlisting>
	struct kbd_repeat kbdrep;
	kbdrep.rate = rate;
	kbdrep.delay = delay;
	ioctl(fd, KDKBDREP, &amp;kbdrep);  /* m68k, i386 */

	fd = open("/dev/kbd", O_RDONLY);
	ioctl(fd, KIOCSRATE, &amp;kbdrep); /* sparc */
	</programlisting>
    </para>

    <para>
	The oldfashioned way of setting keyboard repeat rate
	on i386 was by direct port access. The <constant>KDKBDREP</constant>
	ioctl occurred in old m68k patches, but presently occurs in the stock
	kernel and is also usable for other architectures - they have to
	fill the function pointer <varname>kbd_rate</varname> in
	<filename>vt.c</filename>.
	The sparc uses a different name.
	See also kbdrate(8).
    </para>
   </sect1>

   <sect1 id="KeyboardSignal">
    <title>The Keyboard Signal</title>
    <para>
	<programlisting>
	long sig;
	ioctl(fd, KDSIGACCEPT, sig);
	</programlisting>
    </para>

    <para>
	A program can indicate its willingness to receive keyboard signals
	by executing the <constant>KDSIGACCEPT</constant> ioctl.
	For example, init(8) does this, and upon receipt of a keyboard
	signal performs the action described after the "kb" label.
	The requested signal <varname>sig</varname> is sent when
	the key combination that maps to the keysym KeyboardSignal
	is pressed. This has been used to spawn a new console each
	time this key combination is pressed, and the terminology used
	still reflects that. See also <filename>spawn_console.c</filename>
	in the kbd package.
    </para>
   </sect1>

  </chapter>


</book>
