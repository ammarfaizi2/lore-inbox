Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWA3TCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWA3TCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWA3TCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:02:33 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:64463 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S964881AbWA3TCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:02:32 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
Date: Mon, 30 Jan 2006 20:02:17 +0100
User-Agent: KMail/1.7.2
References: <20060128182522.GA31458@havoc.gtf.org> <200601300936.43977.ioe-lkml@rameria.de> <43DDD206.6000502@gmail.com>
In-Reply-To: <43DDD206.6000502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302002.18962.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 30 January 2006 09:44, Tejun Heo wrote:
> So, are you saying....
> 
> struct ata_classes {
> 	unsigned int classes[2];
> |;
> 
> is safer than
> 
> unsigned int *class;
> 
> ?
 
No, but with a little bit of additional code it CAN be safer.

Or maybe, we can store the classification in a different way.

What about putting the information directly into "ap->device[INDEX].class" 
in the sole caller (ata_drive_probe_reset) so far?

> > So please let the core layer pass a bounded array here or provide
> > a function from core layer to set that and check the index.
> > 
> 
> Can you show me what you have in mind as code?
 
/* Define this to 15, if you need to */
#define ATA_MAX_CLASSES 2
struct ata_set {
        unsigned int class[ATA_MAX_CLASSES];
};

void set_ata_class(struct ata_set *cls, unsigned int idx, unsigned int what)
{
        BUG_ON(idx >= ARRAY_SIZE(cls->class);
        cls->class[idx] = what;
}

set_ata_class(&myclass, 0, what);

You can enforce that even better by making "what" 
a typedef like we do it with pte/pmd/pud/pgd in the VM.

But I prefer not passing this class stuff around, which would even safe
arguments and thus reduce code size.

Maybe we should even have a classify ata port operation instead?


Regards

Ingo Oeser

