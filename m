Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDYI2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDYI2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDYI2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:28:11 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49037 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751417AbWDYI2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:28:10 -0400
Subject: Re: [patch 13/13] s390: dasd device identifiers.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
In-Reply-To: <20060424164907.7888c685.akpm@osdl.org>
References: <20060424150620.GN15613@skybase>
	 <20060424164907.7888c685.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 25 Apr 2006 10:28:13 +0200
Message-Id: <1145953693.5282.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 16:49 -0700, Andrew Morton wrote:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > @@ -45,6 +45,7 @@ struct dasd_devmap {
> >          unsigned int devindex;
> >          unsigned short features;
> >  	struct dasd_device *device;
> > +	struct dasd_uid uid;
> >  };
> 
> Someone's missing a TAB key.

I have to find some script that checks for the damned tabs.

> > +static ssize_t
> > +dasd_alias_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct dasd_devmap *devmap;
> > +	int alias;
> > +
> > +	devmap = dasd_find_busid(dev->bus_id);
> > +	spin_lock(&dasd_devmap_lock);
> > +	if (!IS_ERR(devmap))
> > +		alias = devmap->uid.alias;
> > +	else
> > +		alias = 0;
> > +	spin_unlock(&dasd_devmap_lock);
> > +
> > +	return sprintf(buf, alias ? "1\n" : "0\n");
> > +}
> 
> The locking is suspicious.  We take a spinlock just for a single read?

We could remove the locking for single read/writes, devmap structures
are never deleted so it is safe to access a single value after the
dasd_find_busid. But it is not so easy for the vendor and serial string,
these are not single values so we need some kind of locking. To keep
things symmetrical the lock is used for alias as well. There is a bug
though, only the pointer to the vendor/serial string is read under the
lock, the copy is done outside the lock. If that races with a
dasd_set_uid call funny things might happen. The copy needs to be done
inside the lock. Horst ?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


