Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRATVgu>; Sat, 20 Jan 2001 16:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRATVgk>; Sat, 20 Jan 2001 16:36:40 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:32530 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S132698AbRATVgW>; Sat, 20 Jan 2001 16:36:22 -0500
Message-ID: <3A6A044F.7974AF67@psychosis.com>
Date: Sat, 20 Jan 2001 16:34:07 -0500
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
Organization: www.psychosis.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1p8-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: md= broken. Found problem. Can't fix it.  : (
Content-Type: multipart/mixed;
 boundary="------------A3E997BDC42289C3856B5B4E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A3E997BDC42289C3856B5B4E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have multiple Linux hosts on a SAN, making autodetect of raid devices
dangerous. This problem should be solved by specing an 'md=' for each device on
the cmdline, but unfortuantly it's broken.

Between a few emails to mingo and several wasted hours, I've managed to figure
out the problem. However I don't know how to fix it; it *should*
be working from what I can see.

My only guess right now is because I'm using gcc 2.95.2, and it's doing
something funky. (And I do not have another version to test with right now.)

The problem is during parsing of the md= line, name_to_kdev_t() is not
returning the proper k_dev_t for the device. (IE /dev/sdd5 returns as
16:45 /dev/sde5 returns as 20:05.)

However if I pass static text to name_to_kdev_t(), it works. I first believed
it was in how the str pointer was sent to name_to_kdev_t(), (running over into
comma's, instead of seperate terminated strings) I
fixed that but the problem persists.

My current test for loop is attached. The hard coded device names
printk out to a proper major:minor. The devicenames obtained from
'str' don't. I don't see the bug in here or name_to_kdev_t()...

I'm testing this with the following cmdline:
root=/dev/md0 raid=noautodetect md=0,/dev/hdd5,/dev/hde5
md=1,/dev/hdd6,/dev/hde6  md=2,/dev/hdd7,/dev/hde7
md=3,/dev/hdd8,/dev/hde8 mem=524288K


-- 
"Nobody will ever be safe until the last cop is dead."
		NH Rep. Tom Alciere - (My new Hero)
--------------A3E997BDC42289C3856B5B4E
Content-Type: text/x-csrc; charset=us-ascii;
 name="md-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md-test.c"

2.4.1prepatch 8
drivers/md/md.c line 3722

	for (; i < MD_SB_DISKS && str; i++) {
		/*
		if ((device = name_to_kdev_t(str))) {
			md_setup_args.devices[minor][i] = device;
		} else {
			printk ("md: Unknown device name, %s.\n", str);
			return 0;
		}
		if ((str = strchr(str, ',')) != NULL)
			str++;
		*/
		
		char *ndevstr;
		ndevstr = strchr(str, ',');	// Goto ','
		if (ndevstr != NULL)
			*ndevstr++ = 0;		// Zero it for proper string
		
		// DEBUG Print device name
		printk("Checking: '%s'\n", str);	
		
		
		// Convert device name to k_dev_t and assign to md_setup_args.devices
		// DEBUG As test, hardcode device names for /dev/md0.0 and /dev/md0.1
		if (minor == 0 && i == 0)
			md_setup_args.devices[minor][i] = name_to_kdev_t("/dev/sdd5");
		else if (minor == 0 && i == 1)
			md_setup_args.devices[minor][i] = name_to_kdev_t("/dev/sde5");
		else
			md_setup_args.devices[minor][i] = name_to_kdev_t(str);
		
		// DEBUG Print out kdevname of md_setup_args.devices
		printk("\t%s\n", kdevname(md_setup_args.devices[minor][i]));
		// DEBUG Print minor and i (insync?)
		printk("minor=%d, i=%d\n",minor, i);
		
		// name_to_kdev_t() returned 0. Invalid device 
		if (md_setup_args.devices[minor][i] == 0) {
			printk ("md: Unknown device name, %s.\n", str);
			return 0;
		}
		// Jump to next devname in str
		str = ndevstr;
	}

--------------A3E997BDC42289C3856B5B4E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
