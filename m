Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVDQSBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDQSBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDQSBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 14:01:42 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:16458 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261380AbVDQSBd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 14:01:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daF/LQIkvXd0XiTepC260tIQ3h7NaOI6DB65JixJwebMWxi9l0ztJeE3jnzKuPXo2Dvwc5rOrAd2iVHTGNDKRrmOHGV9znm7mH5PytHO+UEy5OZ0lT71uADcG8sRsGTZOt50ZTQj0ZAMnbZ1RV0Ha26OgJQqv7cgQWYh8yTBNOs=
Message-ID: <a4e6962a050417110160a464d8@mail.gmail.com>
Date: Sun, 17 Apr 2005 13:01:31 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050320151212.4f9c8f32.akpm@osdl.org>
	 <E1DE2D1-0005Ie-00@dorka.pomaz.szeredi.hu>
	 <20050325095838.GA9471@infradead.org>
	 <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu>
	 <20050331112427.GA15034@infradead.org>
	 <E1DH13O-000400-00@dorka.pomaz.szeredi.hu>
	 <20050331200502.GA24589@infradead.org>
	 <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu>
	 <20050411114728.GA13128@infradead.org>
	 <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
>   1) Only allow mount over a directory for which the user has write
>      access (and is not sticky)
> 
>   2) Use nosuid,nodev mount options
> 
> [ parts deleted ]

Do these solve all the security concerns with unprivileged mounts, or
are there other barriers/concerns?  Should there be ulimit (or rlimit)
style restrictions on how many mounts/binds a user is allowed to have
to prevent users from abusing mount privs?

I was thinking about this a while back and thought having a user-mount
permissions file might be the right way to address lots of these
issues.  Essentially it would contain information about what
users/groups were allowed to mount what sources to what destinations
and with what mandatory options.

You can get the start of this with the user/users/etc. stuff in
/etc/fstab, but I was envisioning something a bit more dynamic with
regular expression based rules for sources and destinations.   So,
something like:

# /etc/usermounts: user mount permissions

# <fs>                        <mount point>          <type>               <opts>

# allow users to mount any file system under their home directory
*                                   $HOME                       *     
                   nosuid, nosgid
# allow users to bind over /usr/bin as long as its only in their
private namespace
*                                   /usr/bin                      
bind                    newns
# allow users to loopback mount distributed file systems to /mnt
127.0.0.1                      /mnt                           *       
                 nosuid, nosgid
# allow users to mount files over any directory they have right access to
*                                   (perm=0222)             *         
               nosuid, nosgid

Is this unnecessary?  Is this not enough?

           -eric
