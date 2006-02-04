Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWBDNOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWBDNOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBDNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:14:35 -0500
Received: from verein.lst.de ([213.95.11.210]:6083 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751461AbWBDNOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:14:34 -0500
Date: Sat, 4 Feb 2006 14:14:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Weinhuber <wein@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390: dasd extended error reporting module.
Message-ID: <20060204131418.GA24721@lst.de>
References: <20060201115649.GA9361@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201115649.GA9361@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 12:56:49PM +0100, Heiko Carstens wrote:
> From: Stefan Weinhuber <wein@de.ibm.com>
> 
> The DASD extended error reporting is a facility that allows to
> get detailed information about certain problems in the DASD I/O.
> This information can be used to implement fail-over applications
> that can recover these problems.
> This is a resubmit of this patch because at first submission it
> didn't get included due to Christoph's ioctl changes.
> Since these aren't in the -mm tree anymore this one should be
> merged now.

NACK again.  (although andrew unfortunately pushed this to Linus
already, it would be good if this went out again before 2.6.16).

If you really want this functionality in a separate module you need
to call try_module_get on the module structure of the eer module
everytime before calling into it.  You need to register a structure
ala

struct dasd_eer_ops {
	struct module *owner;
	void (*disable_on_device)(struct dasd_device *);
	void (*write_trigger)(struct dasd_eer_trigger *);
};

and then have wrappers in the core dasd code ala

eer_disable_on_device(struct dasd_device *dev)
{
	if (try_module_get(eer_ops->owner)) {
		eer_ops->write_trigger(dev);
		module_put(eer_ops->owner);
	}
}

the module_get/put on THIS_MODULE in the patch are completely broken.

the ioctl registration is also totally not acceptable.  firtly this
interface is absolutely suitable for sysfs, although that might only work
if it's in the main module.  But even if you go for ioctls it should be
on your separate char device and not use the broken dynamic ioctl
registration which _must_ not be used in any new code.

Besides that there's tons of the usual style issues on the code, please
use mutexes, please make lots of variables that could be static, etc.

