Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRDGRrh>; Sat, 7 Apr 2001 13:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRDGRYL>; Sat, 7 Apr 2001 13:24:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23215 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129112AbRDGRX5>;
	Sat, 7 Apr 2001 13:23:57 -0400
Message-ID: <3ACF4D0F.9D15EB7F@mandrakesoft.com>
Date: Sat, 07 Apr 2001 13:23:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
Cc: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <3ACEFB05.C9C0AB3C@eunet.at> <20010407131631.A3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Sat, Apr 07, 2001 at 01:33:25PM +0200, Michael Reinelt wrote:
> 
> > Adding PCI entries to both serial.c and parport_pc.c was that easy....
> 
> And that's how it should be, IMHO.  There needs to be provision for
> more than one driver to be able to talk to any given PCI device.

No, because that gets really ugly.  You have to create a shim driver
which allocates resources, and registers subsystems.  Only a single PCI
driver like this know best how to locate and allocate resources.  You
can wish to hack such into the serial or parallel driver's PCI probe id
lists, but that won't work for this case, and trying to do it any other
way looks suspiciously like a hack :)

You asked in your last message to show you code, here is a short
example.  Note that I would love to rip out the SUPERIO code in parport
and make it a separate driver like this short, contrived example.  Much
more modular than the existing solution.

static int __devinit foo_init_one (...)
{
	u32 tmp;
	int rc;
	struct serial_port serial;
	struct parport parport;

	pci_read_config_byte(pdev, 0x40, &tmp);
	serial.irq = tmp & 0xFF;
	pci_read_config_word(pdev, 0x42, &tmp);
	serial.port = tmp & 0xFFFF;

	rc = register_serial(&serial);
	if (rc < 0)
		return rc;

	pci_read_config_byte(pdev, 0x40, &tmp);
	parport.irq = tmp & 0xFF;
	pci_read_config_word(pdev, 0x42, &tmp);
	parport.port = tmp & 0xFFFF;

	rc = register_parport(&parport);
	if (rc < 0)
		return rc;

	return 0;
}
static void __init foo_init(void) {
	return pci_module_init(&foo_driver);
}
static void __exit foo_exit(void) {
	pci_unregister_driver(&foo_driver);
}
module_init(foo_init);
module_exit(foo_exit);

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
