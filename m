Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264014AbUDFVOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbUDFVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:14:05 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:49855 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264014AbUDFVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:10:50 -0400
Date: Tue, 6 Apr 2004 22:08:11 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406210811.GA10142@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <200404062237.02210.volker.hemmann@heim10.tu-clausthal.de> <20040406204843.GC1100@redhat.com> <200404062304.12089.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404062304.12089.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 11:04:11PM +0200, Hemmann, Volker Armin wrote:

 > > It survives a testgart run too ?
 > I am amazed, too, that may box is running... ;o)
 > testgart works,  I did a fresh reboot, to be sure:

Ok, too strange for words.
I'm inclined to make things more explicit, and make
sis_get_driver look like this..

static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
{
    if (bridge->dev->device == PCI_DEVICE_ID_SI_648) {
        sis_driver.agp_enable=sis_648_enable;
        if (agp_bridge->major_version == 3) {
            sis_driver.aperture_sizes       = agp3_generic_sizes;
            sis_driver.size_type            = U16_APER_SIZE;
            sis_driver.num_aperture_sizes   = AGP_GENERIC_SIZES_ENTRIES;
            sis_driver.configure            = agp3_generic_configure;
            sis_driver.fetch_size           = agp3_generic_fetch_size;
            sis_driver.cleanup              = agp3_generic_cleanup;
            sis_driver.tlb_flush            = agp3_generic_tlbflush;
        }
    }
                                                                                                                            
    if (bridge->dev->device == PCI_DEVICE_ID_SI_746) {
        /*
         * We don't know enough about the 746 to enable it properly.
         * Though we do know that it needs the 'delay' hack to settle
         * after changing modes.
         */
        sis_driver.agp_enable=sis_648_enable;
    }
}


 > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
 > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
 > agpgart: sis 648 agp fix - giving bridge time to recover
 > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode

It's pretty convinced it's in AGPv3 mode too.
Oh well. 8-)

		Dave
