Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272195AbRH3Mrn>; Thu, 30 Aug 2001 08:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRH3Mre>; Thu, 30 Aug 2001 08:47:34 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:63627 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S272195AbRH3MrR>; Thu, 30 Aug 2001 08:47:17 -0400
Message-ID: <3B8E35E3.51DBDC34@pandora.be>
Date: Thu, 30 Aug 2001 14:47:31 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
Newsgroups: be.comp.os.linux
To: linux-kernel@vger.kernel.org
Subject: EISA irq probing problem (ESIC chip)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to write a linux driver for an EISA data aquisition card. 
More info on my little special project is at
http://mc303.ulyssis.org/heim/

I am able to probe for the EISA ID, but i can't get the irq level from
the card...  this is how I *think* it is done, please correct me if
possible...

I have been grepping all over the kernel source to find EISA drivers,
and i came along /usr/src/linux/drivers/net/defxx.c... When I looked
at the header file, I saw that under the section "/* Define EISA
controller register offsets */" all the registers (the ones with ESIC
in the define string) seemed to match with the registers I have on my
EISA controller (HD64981F EISA Slave Interface Controller, ESIC ->
found nothing on the web), and also the defxx.c driver supports FDDI,
and my card also has a connector for an optical cable, so i guess we
are talking about the same controller here....

Then I looked at how the defxx.c driver gets the interrupt level from
the ESIC chip (see source) and I decided to try and do it the same
way, like this:

...
#define DISC_ESIC_K_FUNCTION_CNTRL      0xCAE
#define DISC_ESIC_K_CSR_IO_LEN         
DISC_ESIC_K_FUNCTION_CNTRL+1    /* alwa
ys last reg + 1 */
...
#define DISC_CONFIG_STAT_0_M_IRQ        0x03
#define DISC_CONFIG_STAT_0_V_IRQ        0
...
#define DISC_CONFIG_STAT_0_IRQ_K_4      0
#define DISC_CONFIG_STAT_0_IRQ_K_5      1
#define DISC_CONFIG_STAT_0_IRQ_K_6      2
#define DISC_CONFIG_STAT_0_IRQ_K_7      3

...

static int getslotinfo(void)
{
        u8 val;

        if (!request_region(0x1000, DISC_ESIC_K_CSR_IO_LEN, "disc")) {
                printk(KERN_ERR "disc.c: Cannot reserve I/O
resource!\n");
                return -EBUSY;
        }       

        val = inb(0x1000+0xCA9);
        printk
        switch ((val & DISC_CONFIG_STAT_0_M_IRQ) >>
DISC_CONFIG_STAT_0_V_IRQ)
                {
                case DISC_CONFIG_STAT_0_IRQ_K_4:
                        DiSC_Id.it = 4;
                        break;

                case DISC_CONFIG_STAT_0_IRQ_K_5:
                        DiSC_Id.it = 5;
                        break;

                case DISC_CONFIG_STAT_0_IRQ_K_6:
                        DiSC_Id.it = 6;
                        break;

                case DISC_CONFIG_STAT_0_IRQ_K_7:
                        DiSC_Id.it = 7;
                        break;

                default:
                        printk(KERN_WARNING "disc: found no matching
IRQ!\n");
                        return 1;
                }
        printk(KERN_WARNING "disc: DiSC_Id.it=%d\n", DiSC_Id.it);
        release_region(0x1000, DISC_ESIC_K_CSR_IO_LEN);

        return 0;
}

I know my EISA card is at the first slot (0x1000).  The register that
is defined at offset 0xCA9 has the following bits:

Bit 7:
	0: No interrupt pending from LIREQ0
	1: Interrupt pending from LIREQ0
	( Bit 7 is automatically cleared after the register is read if LIREQ0
is set to edge-triggered input (bit 4 is set to 1).

Bit 6: reserved

Bit 5:
	0: Corresponding IRQx is level-sensitive input
	1: Corresponding IRQx is edge-triggered output

Bit 4:
	0: LIREQ0 is level-sensitive input
	1: LIREQ0 is edge-triggered input

Bit 3:
	0: Disable interrupt request LIREQ0
	1: Enable interrupt request LIREQ0

Bit 2: reserved

Bit 1 and Bit 0:
	00: LIREQ0 is assigned to IRQ0
	01: LIREQ0 is assigned to IRQ1
	10: LIREQ0 is assigned to IRQ2
	11: LIREQ0 is assigned to IRQ3


So if i understand my code, what is it doing is that is first masks
with the mask for interrupts to get only the last two bits, then it
shifts 0 bits to the right so we can read the interrupt as a number
and then depending on the number we read, it checks which IRQ level is
stored on the card.

And here is where the problem comes up!!!!!!!!!!!!!!!!!!!

With the DOS utility, called "ECU" (EISA Configuration Utility), I can
assign the card to IRQ 4, 5, 6 or 7.  So i guess 4 maps to 00, 5 to
01, 6 to 10 and 7 to 11.
Then I set the card up for -let say for example- IRQ 4 with the ECU.
Then I boot a dos program (see URL in the beginning of this mail) that
uses the card and where I put some printf's just to be able to see
what interrupt level it is reading (the DiSC_ID.it value in the
getslotinfo() function), i can see that it indeed is using irq 4. (The
dos program finds the it level by generating an INT15/D801H, see DOS
code on page)

The problem is... when i try the same thing with my above linux code
(not on the site yet, site contains older version!) i do not get the
correct irq... seems like the values at 0x1CA9 never have changed, no
matter what IRQ i set up with the ECU utility (although i *KNOW* it
has changed because the DOS program tells me so...)

Am I forgetting something here?  I already tried with or without the
request_region function call, I inspected the io range with hexdump
and it seems like the values at 0x1caeh remain the same????  How is
this possible???  They should've been changed because I used the ECU
to change them???

There is also a second Interrupt Channel Configuration and Status
Register at offset xCAAH, the bits are exactly the same but instead of
LIREQ0 it is for LIREQ1.  I also tried all the above with this offset,
without result...

I went through the defxx.c code but I can't see what it is doing more
than my code :-(

What could i possibly doing wrong here???


Regards,
Bart Vandewoestyne

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
