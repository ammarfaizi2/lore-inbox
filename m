Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVHSHjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVHSHjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHSHjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:39:43 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:4631 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964888AbVHSHjn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:39:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P6Xsow481v0UGs9RHDdXFWvGLugyNL0qPHUKE1ZfYsTG7Jr0NoOyjOl58jMouGfx+TjtWvWNDk8+DdaZKXSAoGYwBeOn03JShLJgij0KCD/2A4BCzt784XTunSVr0XLB6dy6FpBVsfujMYLG14pPGseFT3NY+aKJhpDnotSo3Fw=
Message-ID: <84144f020508190039322a486c@mail.gmail.com>
Date: Fri, 19 Aug 2005 10:39:39 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: sysfs: write returns ENOMEM?
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <200508190055.25747.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508190055.25747.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 8/19/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> According to the SuS write() can not return ENOMEM, only ENOBUFS is allowed
> (surprisingly read() is allowed to use both ENOMEM and ENOBUFS):
> 
> http://www.opengroup.org/onlinepubs/000095399/functions/write.html
> 
> Should we adjust sysfs write to follow the standard?

Please note that sysfs is not the only one to do this. A quick peek
reveals XFS and CIFS returing ENOMEM for write() and there are
probably others as well. Perhaps we should replace ENOMEM with ENOBUFS
in vfs_write() instead?

linvfs_write
	xfs_write
		xfs_zero_eof
			xfs_zero_last_block
				xfs_iozero
					-> Returns -ENOMEM

cifs_user_write
	cifs_reopen_file
		-> Returns -ENOMEM

                            Pekka
