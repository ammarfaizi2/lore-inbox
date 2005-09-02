Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbVIBWzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbVIBWzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVIBWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:55:17 -0400
Received: from smtp06.auna.com ([62.81.186.16]:49812 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1161095AbVIBWzP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:55:15 -0400
Date: Fri, 02 Sep 2005 22:55:09 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.13-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <fa.hqupr0d.1u3af35@ifi.uio.no> <4317AD4D.6030001@reub.net>
	<1125626219l.6072l.0l@werewolf.able.es>
	<20050901190655.345914ba.akpm@osdl.org>
	<1125676407l.6262l.0l@werewolf.able.es>
	<20050902144552.77c92d06.akpm@osdl.org>
In-Reply-To: <20050902144552.77c92d06.akpm@osdl.org> (from akpm@osdl.org on
	Fri Sep  2 23:45:52 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1125701709l.7399l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sat, 3 Sep 2005 00:55:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.02, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > 
> > On 09.02, Andrew Morton wrote:
> > > "J.A. Magallon" <jamagallon@able.es> wrote:
> > > >
> > > > 
> > > > On 1/09/2005 10:58 a.m., Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > > > > 
> > > > > - Included Alan's big tty layer buffering rewrite.  This breaks the build on
> > > > >   lots of more obscure character device drivers.  Patches welcome (please cc
> > > > >   Alan).
> > > > > 
> > > > 
> > > > I have problems with udev and latest -mm.
> > > > 2.6.13 boots fine, but 2.6.13-mm1 blocks when starting udev.
> > > > System is Mandriva Cooker. As cooker, things are changing fast (initscripts,
> > > > udev, etc), but the fact is that with the same setup, plain .13 boots
> > > > and -mm1 blocks. Udev is 068 version.
> > > > 
> > > > Any idea about what can be the reason ?
> > > > 
> > > 
> > > There's some suspect locking in the /proc/devices seq_file conversion code.
> > > 
> > > Could you revert convert-proc-devices-to-use-seq_file-interface-fix.patch
> > > then convert-proc-devices-to-use-seq_file-interface.patch?
> > > 
> > 
> > Still the same result, system bocks starting udev...
> > 
> 
> OK, thanks.   Nothing from sysrq-t?  Does the below help?
> 
> --- devel/fs/sysfs/file.c~gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix	2005-09-02 04:01:40.000000000 -0700
> +++ devel-akpm/fs/sysfs/file.c	2005-09-02 04:05:02.000000000 -0700
> @@ -202,13 +202,14 @@ fill_write_buffer(struct sysfs_buffer * 
>   *	passing the buffer that we acquired in fill_write_buffer().
>   */
>  
> -static int 
> -flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t count)
> +static int flush_write_buffer(struct dentry *dentry,
> +			struct sysfs_buffer *buffer, size_t count_in)
>  {
>  	struct attribute * attr = to_attr(dentry);
>  	struct kobject * kobj = to_kobj(dentry->d_parent);
>  	struct sysfs_ops * ops = buffer->ops;
>  	char *x;
> +	size_t count = count_in;
>  
>  	/* locate trailing white space */
>  	while ((count > 0) && isspace(buffer->page[count - 1]))
> @@ -224,7 +225,8 @@ flush_write_buffer(struct dentry * dentr
>  	/* terminate the string */
>  	x[count] = '\0';
>  
> -	return ops->store(kobj, attr, x, count);
> +	ops->store(kobj, attr, x, count);
> +	return count_in;
>  }
>  

Bingo !.

That did the trink. Booting fine again.
I meant, just with this, without reverting the other 2 patches.

Thanks !

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam2 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


