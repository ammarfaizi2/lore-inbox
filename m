Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264215AbRFWX7L>; Sat, 23 Jun 2001 19:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbRFWX7B>; Sat, 23 Jun 2001 19:59:01 -0400
Received: from imladris.infradead.org ([194.205.184.45]:29970 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S264215AbRFWX6m>;
	Sat, 23 Jun 2001 19:58:42 -0400
Date: Sun, 24 Jun 2001 00:58:27 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: For comment: draft BIOS use document for the kernel
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106240031470.14042-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

Brief critique...

 > Linux 2.4 BIOS usage reference

 > Boot Sequence
 > -------------
 >
 > Linux is normally loaded either directly as a bootable floppy
 > image or from hard disk via a boot loader called lilo. The
 > kernel image is transferred into low memory and a parameter
 > block above it.
 >
 > When booting from floppy disk the BIOS disk parameter tables are
 > replaced by a new table set up to allow a maximum sector count
 > of 36 (the track size for a 2.88Mb ED floppy)
 >
 > int 0x13, AH=0x02 is issued to to probe and find the disk geometry.
 > int 0x13, AH=0x00 is used to reset the floppy controller.
 > int 0x13, AH=0x02 is then issued repeatedly to load tracks of
 >	data. The boot loader ensures no issued requests cross the
 >	track boundaries
 >
 > int 0x10 service 3 is used during the boot loading sequence to
 > obtain the cursor position. int 0x10 service 13 is used to
 > display loading messages as the loading procedure continues. int
 > 0x10 AH=0xE is used to display a progress bar of '=' characters
 > during the bootstrap
 >
 > Control is then transferred to the loaded image whether by the
 > floppy boot loader or other services

That looks OK.

 > Kernel Setup
 > ------------
 >
 > The initial kernel setup executes in 16bit mode. While in 16bit
 > mode the kernel calls and caches data from several 16bit calls
 > whose data is not available in 32bit mode
 >
 > It then uses int 0x10 AH=0x0E in order to print initial progress
 > banners so that immediate feedback on the boot status is
 > available. The 0x07 character is issued as well as printable
 > characters and is expected to generate a bell.
 >
 > Memory detection is done as follows, attempting to handle the
 > various methods that have been available over time

That looks OK.

 > Memory Sizing
 > -------------
 >
 > Firstly a call is made to BIOS INT 15 AX=0xE820 in order to read
 > the E820 map. A maximum of 32 blocks are supported by current
 > kernels. The 'SMAP' signature is required and tested. In
 > addition the SMAP signature is restored each call, although not
 > required by the specification in order to handle some know BIOS
 > bugs.
 >
 > If the E820 call fails then the INT 15 AX=0xE801 service is
 > called and the results are sanity checked. In particular the
 > code zeroes the CX/DX return values in order to detect BIOS
 > implementations that do not set them usable memory data.

That looks OK.

 > It also handles older BIOSes that return AX/BX but not AX/BX data.

Please explain that a little more clearly - it means nothing to me.

 > When service E801 is used the kernel assumes that usable memory
 > extends from 4K to the bottom of the EBDA, and from 1Mbyte to
 > the top of the E801 area.
 >
 > If neither service is available then INT 0x15 AH=0x88 is invoked
 > in order to get the memory size, up to 64Mb by the original IBM
 > PC BIOS service.

That looks OK.

 > Peripherals
 > -----------
 >
 > Having sized memory the kernel moves on to set up peripherals.
 > The BIOS INT 0x16, AH=0x03 service is invoked in order to set
 > the keyboard repeat rate and the video BIOS is the called to set
                                                  ^^^
 > up video modes.

Assuming that should be "then", that's fine.

 > The kernel tries to identify the video in terms of its generic
 > features. Initially it invokes INT 0x10 AH=0x12 to test for the
 > presence of EGA/VGA as oppose to CGA/MGA/HGA hardware.
 >
 > INT 0x10 AH=0x03 is used to obtain the cursor position, and INT
 > 0x10, AH=0x0F is used to obtain the video page and the mode. If
 > EGA or VGA are present the normal BIOS locations of 0x485 and
 > 0x484 are used to obtain the font size and the screen height.
 >
 > VESA BIOS video services are used to obtain the amount of video
 > memory (INT 0x10 AX=0x4F00) and then to obtain the VESA 2.0
 > protected mode interface data if available (INT 0x10,
 > AX=0x4F0A). Users are able to select graphical video modes (INT
 > 0x10 AX=0x4F02), or if not available the pre VESA mode setup.
 > The presence of the VESA BIOS is checked by the VESA get mode
 > information call (INT 0x10 AX=0x4F01)

That's fine.

 > Special modes will also invoke INT 0x10 AH=0x1200 (Alternate
 > print screen), INT 0x10 AH=0x11 (to set 8x8 font), INT 0x10
 > AH=0x1201 (to turn off cursor emulation) and INT 0x10 AH=0x01
 > (to set up the cursor).

What do you mean by "Special modes" ?

 > Having completed video set up the hard disk data for hda and hdb
 > is copied from the low memory BIOS area into the kernel tables.
 > INT 0x13 AH-0x15 is used to check if a second disk is present.

Is that only for hda and hdb, or is hdc/hdd checked for as well?

 > INT 0x15, AH=0xC0 is invoked in order to check for MCA bus
 > machines. If an MCA systab is available the first block of the
 > table is also saved into the kernel's own data areas.

That's fine.

 > INT 0x11 is used to check for a PS/2 mouse. If this function
 > reports that a PS/2 pointing device is present the kernel will
 > also verify directly with the PS/2 controller itself that the
 > mouse is attached.

That paragraph could use expanding to explain whether it also checks
for a PS/2 keyboard, and how it deals with systems with the one but
not the other (either way round).

 > Power Management
 > ----------------
 >
 > Linux supports APM power management. It will issue APM BIOS
 > service calls in order to set up power management, and if
 > present will then issue calls to the 32bit APM services after
 > boot up.
 >
 > During boot the kernel issues INT 0x15 AX=0x0530 in order to do
 > an APM BIOS installation check. It requires that a 32bit capable
 > APM BIOS is present. Assuming a valid 32bit capable APM BIOS is
 > reported the kernel will then issue an APM disconnect (INT 0x15
 > AX=0x5304) followed by a 32bit connect (INT 0x15 AX=0x5303).
 >
 > The kernel then issues an APM installation check again (INT 0x15
 > AH=0x5300)  in order to check if the BIOS feature flags have
 > changed now 32bit mode has been selected. Finally it checks the
 > signature and saves the parameters.
 >
 > At this point use of 16bit BIOS services cease and the kernel
 > begins talking directly to the hardware. It enters 32bit mode
 > and transfers execution to the 32bit kernel proper.

 > 32bit Bootstrap
 > ---------------
 >
 > The 32bit bootstrap runs mostly independently of BIOS services.
 > It does however scan for and use certain tables if they are
 > present.
 >
 > PCI BIOS is used if the user requests it or PCI configuration
 > type 1 and type 2 are not available on the system. At that point
 > the kernel searches for the BIOS32 signature and then for the
 > PCI signatures "PCI " and "$PCI"
 >
 > The kernel invokes the PCI_BIOS_PRESENT function initially, in
 > order to test the availability of PCI services in the firmware.
 > Assuming this is found them PCIBIOS_FIND_PCI_DEVICE,
 > PCIBIOS_FIND_PCI_CLASS_CODE, PCIBIOS_GENERATE_SPECIAL_CYCLE,
 > PCIBIOS_READ/WRITE_CONFIG_BYTE/WORD/DWORD calls are issued as
 > the PCI service are configured, along with
 > PCIBIOS_GET_ROUTING_OPTIONS and PCIBIOS_SET_HW_INT to handle
 > plug and play devices.
 >
 > In the majority of systems the kernel will directly invoke type
 > 1 or type 2 configuration. In this situation the kernel will
 > search for a $PIR PCI IRQ routing table in the BIOS area
 > (0xF0000->0xFFFFF) with a revision of 0x100 (1.0).

That makes sense.

 > Multiprocessor Machines
 > -----------------------
 >
 > The kernel will also search for an Intel MP 1.1 or MP 1.4 table.
 > If this is found it is used to obtain the multiprocessor data
 > required to boot the other processors as well as the APIC
 > information, including IRQ routing tables. Some older Linux boot
 > loaders would overwrite the EBDA if it was more than 4K, so the
 > SMP tables are best placed elsewhere for Linux compatibility.
 > One extension the Linux kernel makes to the official rules for
 > parsing this table, is that in the presence of PCI/ISA machines
 > it will probe for and use the EISA ELCR configuration register
 > if it appears to be present.
 >
 > If multiprocessor capability is detected then APM BIOS service
 > usage is disabled except for poweroff. The APM specification and
 > the behaviour of existing APM BIOS implementations under SMP
 > conditions are at best described as 'variable'.

That's fine.

 > VESA BIOS
 > ---------
 >
 > If the user selects a VESA BIOS console the VESA 32bit BIOS
 > calls for screen panning are used in order to scroll the VESA
 > linear frame buffer and to do colour manipulation.
 >
 > Providing the 32 bit VESA BIOS calls are available the kernel
 > calls function 0x4F07 (pan display) in order to implement
 > scrolling. When using an 8bit console depth the palette reload
 > (0x4F09) function is used to reload colour tables. In the
 > absence of the 32bit interface the kernel does software
 > scrolling and assumes the colour registers are VGA compatible
 > hardware.
 >
 > The memory region segment option is not supported. If this is
 > found then the kernel acts as if 32bit VESA extensions are not
 > available.

That makes sense.

 > PnPBIOS
 > -------
 >
 > BIOS plug and play 32bit services are used if present. The
 > functions used are 0x00 (GET_NUM_SYS_DEV_NODES) , 0x01
 > (GET_SYS_DEV_NODE), 0x02 (SET_SYS_DEV_NODE). Docking station and
 > ESCD services are not currently utilised at all. Linux currently
 > makes fairly minimal use of the PnPBIOS services, simply using
 > them to find certain motherboard device configurations.

That makes sense.

 > 32bit Power Management
 > ----------------------
 >
 > When 32bit APM services are available the kernel will use APM
 > facilities to do power management, instead of issuing 'hlt'
 > instructions when idle.
 >
 > After the initial boot up the APM kernel thread issues APM
 > function VERSION (0x530E) specifying a maximum version of 1.2.
 > If this fails it assumes APM 1.0 services. ENGAGE_PM (0x530F) is
 > then issued if the power management is currently disengaged.
 >
 > The APM task then loops handling pending APM requests once a
 > second. GET_EVENT (0x530B) is invoked to process pending events.
 > When the kernel wishes to change power state it will issue
 > SET_STATE (0x5307) in order to transfer state.
 >
 > The idle transition loops will invoke IDLE (0x5305) and BUSY
 > (0x5306) as appropriate to allow the BIOS to execute its power
 > management policy.
 >
 > GET_STATUS(0x530A) is issued when user processes request battery
 > status in order to implement battery monitoring applications.
 >
 > SET_STATE is also issued when the display timer expires in the
 > OS. In this situation the kernel tries to blank the primary
 > display device (0x100) or if this fails to blank all video
 > devices (0x1ff)

That makes sense.

 > Power Management and BIOS Bugs
 > ------------------------------
 >
 > The APM BIOS is a complex subsystem and has historically had
 > many bugs, particularly in older laptop systems. To handle this
 > the APM BIOS supports a variety of options to work around
 > problems
 >
 > Linux will ignore small segment limits provided by the BIOS and
 > always set the segment limit to 64K. This is necessary as some
 > BIOSes get the limit values wrong.
 >
 > Linux will call BIOS functions with a selector of 0x40 pointing
 > to the real mode address base of 0x40:0. Many BIOS functions
 > rely on this selector being present even though the
 > specification does not permit the assumption.
 >
 > Options control whether BIOS functions are invoked with
 > interrupts enabled or disabled. A correctly functioning APM BIOS
 > should not care but some do.
 >
 > Options also control whether the power off is issued 32bit or
 > 16bit, with the kernel transitioning to 16bit before issuing the
 > power off request.
 >
 > Finally the battery status querying can be disabled to work
 > around a small number of BIOSes which crash when this function
 > is used from 32bit space. These options can be keyed from the
 > DMI table scanner, so that, if we are made aware of BIOSes
 > requiring options set specific ways we can automatically set the
 > options correctly for that BIOS without user intervention.

That all makes sense.

 > Power Management Assumptions
 > ----------------------------
 >
 > The Linux 2,4 kernel power management code will restore certain
 > devices itself but it does rely on the BIOS to correctly save
 > and restore the following
 >
 > 	o	MTRR registers
 > 	o	AGP configuration
 > 	o	Hard disk parameters - including waking the drive
 > 		properly on a resume
 >
 > The SMM BIOS code needs to be aware that Linux is not windows.
 > In particular we have seen problems where the save/restore code
 > for the video BIOS is not capable of handling any mode not used
 > by windows.
 >
 > The Linux kernel makes use of certain advanced features, and
 > while these should not intrude into the SMM mode some of them
 > are worth mentioning
 >
 > 	Processor State
 > 		Linux makes use of machine check exceptions, 36bit
 > 		extensions, MTRR registers, and 4Mbyte pages

That all makes sense.

 > 	Interrupt Controllers
 > 		Linux will use the APIC when available, including on newer
 > 		single processor machines. SMM code must be aware that the
 > 		IRQ routing may have been configured for this
 >
 > 	PCI
 > 		In some circumstances Linux will assign PCI bus resources
 > 		and potentially renumber and relocate devices. It tries
 > 		where possible to keep the existing BIOS setup

Those two could use rephrasing to clarify their meaning.

 > Testing Strategy
 > ----------------
 >
 > Because Linux makes little use of the BIOS services it is
 > relatively easy to run a test sequence to get basic validation
 > of APM functionality under Linux.
 >
 > The recommended procedure is as follows
 >
 > 1.	Boot Linux on the system
 > 	Verify the system boots
 > 	[Does basic verification of PCI services, boot up 16bit calls]
 >
 > 	Login to the system
 >
 > 1.1	Type 'free'
 > 	Verify the amount of free memory appears correct
 > 	[Verifies memory reporting is working correctly]
 >
 > 1.2	Type 'cat /proc/apm'
 > 	Verify that the machine does not crash
 > 	[Verifies GET_STATUS 32bit call]
 >
 > 1.3	Type 'apm -s'
 > 	The machine should standby
 >
 > 1.4	Wake it and type 'apm -S'
 > 	The machine should suspend
 >
 > 1.5	Verify the BIOS hot-keys for suspend etc work
 >
 > 1.6	Verify the BIOS suspend to disk works if applicable
 >
 > 1.7	Resume the machine and type 'poweroff'
 >
 > The system should now shutdown

That all appears fine.

 > 2.	Boot Linux on the system
 > 	Start the graphical user interface
 >
 > 	Repeat steps 1.3 to 1.6 from a terminal window in the GUI
 >
 > 	This verifies that the APM suspend/restore correctly handles
 > 	the GUI save/restore
 >
 > 	Add the line "vga=0x0311" to the /etc/lilo.conf
 > 	Rerun lilo
 >
 > 	Repeat step 1.7
 >
 > 3.	Boot the system
 > 	This time the VGA option will try to use VESA BIOS services
 > 	to set a 640x480 16bit mode.
 >
 > 3.1	Login to the system
 >
 > 3.2	Type 'ls -lR /'
 >
 > 	This will cause the screen pan/scrolling BIOS calls to be tested
 > 	After this has scrolled for a bit hit ^C
 >
 > 3.3	Remove the "vga=0x0311" option from /etc/lilo.conf
 > 	Rerun lilo
 >
 > 	This ensures the setup is correct for any future test run

That all appears fine.

 > 4. Additional Laptop Test

First, not all laptops have PCMCIA or CardBus, and second, not all
systems that have those are laptops. Can I suggest...

   4. Additional test for systems with PCMCIA.

...be used instead.

 > 4.1	Boot Linux on the system
 >
 > 4.2	Insert a PCMCIA card, ensure the kernel detects it
 >
 > 4.3	Remove the PCMCIA card, ensure the kernel detects the change
 >
 > 4.4	Insert a cardbus card, ensure the kernel detects it
 >
 > 4.5	Verify the cardbus device is usable
 >
 > 4.6	Remove the cardbus device, ensure the kernel detects it

My only query with that is whether PCMCIA implies CardBus, and what to
do with systems that accept one and not the other.

 > Compatibility With Older (2.2) Linux
 > ------------------------------------
 >
 > Linux 2.2 makes fairly similar BIOS calls to the 2.4 kernel. It
 > does not support PCI plug and play setup and should generally be
 > configured in the BIOS as a non plug and play operating system.

Split into two paragraphs here.

 > On machines with large amounts of memory the earlier 2.2 kernels
 > frequently do not see all of it as they lack the E820 memory
 > sizing code. 2.2 users should probably be advised to upgrade to
 > Linux 2.2.19 or higher on such machines.

Other than splitting where indicated, that's fine.

 > Future Paths
 > ------------
 >
 > Intel are currently working on ACPI support for Linux. While
 > much of this is functional it is not yet stable enough that
 > vendors enable it. Linux does not require APM services to do
 > minimal power management, nor does it require PnPBIOS services
 > to function happily. It does however need to know about
 > interrupt routing. For minimal Linux compatibility a 'legacy
 > free' BIOS should probably provide the $PIR table, even if it
 > does not provide non ACPI versions of other services.

That appears fine.

The only thing I would add to that is either a version number or a
"last changed" date.

Best wishes from Riley.

