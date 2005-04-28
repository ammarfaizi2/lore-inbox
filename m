Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVD1RwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVD1RwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVD1RwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:52:04 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:41506 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262193AbVD1Rv7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:51:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3NuelYD3jSbPFFaqaIe6yPLrFQ9a6e7GEIKXB7ga7g37fYaWBsSc15S15DN0xBPLUshbfC3hmTJxIDqxEIloL1aTJPv1ChFZXqX7qVuxmHEo0m6c0e7637RHRu/x+GAiXpNHc8AeywqzNd+dJ7tE55Y4/1wSL/fT+Sfh8s4++c=
Message-ID: <d120d500050428105153ab13b1@mail.gmail.com>
Date: Thu, 28 Apr 2005 12:51:46 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should return -ENOSYS
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20050428173744.GO23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504280030.10214.dtor_core@ameritech.net>
	 <20050428172659.GA18859@kroah.com>
	 <20050428173744.GO23013@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Wright <chrisw@osdl.org> wrote:
> * Greg KH (gregkh@suse.de) wrote:
> > On Thu, Apr 28, 2005 at 12:30:09AM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > >
> > > Jean Delvare has noticed that if a driver happens to declare its
> > > attribute as RW but doesn't provide store() method attempt to write
> > > into such attribute will cause spinning process as most of the
> > > attribute implementations return 0 in case of missing store causing
> > > endless retries. In some cases missing show/store will return -EPERM,
> > > -EACCESS or -EINVAL.
> > >
> > > I think we should unify implementations and have them all return -ENOSYS
> > > (function not implemented) when corresponding method (show/store) is
> > > missing.
> >
> > What is the POSIX standard for this?  ENOSYS or EACCESS?
> 
> SuSv3 suggests EBADF, however we already do EINVAL at VFS for no write
> op.  Although, returning 0 (i.e. wrote zero bytes) is still meaningful
> too.
> 

Returning 0 causes caller to immediately repeat operation causing the
loop and 100% CPU utiluization as was reported. If ENOSYS is not
acceptable (after all the problem is sysfs-specific, other fs-es
either support write or they don't for entire volume) I'd say (looking
at the descripptions) we should use ENXIO instead of EBADF:

[ENXIO] 
A request was made of a nonexistent device, or the request was outside
the capabilities of the device.

[EBADF] 
The fildes argument is not a valid file descriptor open for writing.

We have a valid FD and it was opened for wrinting, so EBADF is not
really applicable. But then I may be talking complete gibberish...

-- 
Dmitry
