Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269125AbRGaHo6>; Tue, 31 Jul 2001 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269028AbRGaHot>; Tue, 31 Jul 2001 03:44:49 -0400
Received: from zok.sgi.com ([204.94.215.101]:39087 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269020AbRGaHof>;
	Tue, 31 Jul 2001 03:44:35 -0400
Date: Tue, 31 Jul 2001 00:41:32 -0700 (PDT)
From: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Message-Id: <10107310041.ZM233282@classic.engr.sgi.com>
In-Reply-To: Richard Gooch <rgooch@ras.ucalgary.ca>
        "[RFT] Support for ~2144 SCSI discs" (Jul 30,  8:30pm)
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
Cc: devfs-announce-list@mobilix.ras.ucalgary.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

With the sard patch and a 64 bit system, you start having
trouble at around 103 configured disks, because of the following
line in sd_init() (sd.c), because kmalloc doesn't like allocating
large chunks of memory:

        sd = kmalloc((sd_template.dev_max << 4) *
                                          sizeof(struct hd_struct),
                                          GFP_ATOMIC);

Without sard, you'd have problems past 512 disks.


With the sard patch, the hd_struct looks like the following:

struct hd_struct {
        long start_sect;
        long nr_sects;
        devfs_handle_t de;              /* primary (master) devfs entry  */

        int number;                     /* stupid old code wastes space  */

        /* Performance stats: */
        unsigned int ios_in_flight;
        unsigned int io_ticks;
        unsigned int last_idle_time;
        unsigned int last_queue_change;
        unsigned int aveq;

        unsigned int rd_ios;
        unsigned int rd_merges;
        unsigned int rd_ticks;
        unsigned int rd_sectors;
        unsigned int wr_ios;
        unsigned int wr_merges;
        unsigned int wr_ticks;
        unsigned int wr_sectors;
};


The caveat is that I'm looking at a patch that is a few months old (I
couldn't find where the latest version of the kernel patch is).

jeremy

