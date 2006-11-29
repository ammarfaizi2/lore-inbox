Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967345AbWK2OcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967345AbWK2OcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967353AbWK2OcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:32:12 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:23957 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S967345AbWK2OcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:32:11 -0500
Date: Wed, 29 Nov 2006 07:32:10 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: James Smart <James.Smart@Emulex.Com>
Cc: Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/scsi_error.c should #include "scsi_transport_api.h"
Message-ID: <20061129143210.GX14076@parisc-linux.org>
References: <20061129100422.GL11084@stusta.de> <20061129131624.GV14076@parisc-linux.org> <456D958F.2080305@emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456D958F.2080305@emulex.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 09:13:35AM -0500, James Smart wrote:
> would it only go in include/scsi if it intends to be an exported
> api for LLDD's and/or user apps ?  and stay in drivers/scsi if its
> an internal api within the scsi subsystem itself ?

It isn't clear to me that's the intended use of include/scsi.  If it is,
it's already being violated, eg by

$ find * -type f |xargs grep scsi_host_scan_allowed
drivers/scsi/scsi_scan.c:       if (scsi_host_scan_allowed(shost))
drivers/scsi/scsi_scan.c:       if (scsi_host_scan_allowed(shost))
drivers/scsi/scsi_scan.c:       if (scsi_host_scan_allowed(shost)) {
drivers/scsi/scsi_scan.c:       if (!scsi_host_scan_allowed(shost))
include/scsi/scsi_host.h: * scsi_host_scan_allowed - Is scanning of this
host allowed
include/scsi/scsi_host.h:static inline int scsi_host_scan_allowed(struct
Scsi_Host *shost)

(a good candidate to be moved to scsi_scan.c, in fact!)

scsi_host_state_name, scsi_normalize_sense, scsi_reset_provider,
scsi_test_unit_ready, scsi_put_command are all in similar usage to
scsi_schedule_eh.  There's probably more, I just picked some likely
looking candidates.
