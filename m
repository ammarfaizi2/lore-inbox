Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWALJru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWALJru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWALJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:47:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030240AbWALJrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:47:49 -0500
Date: Thu, 12 Jan 2006 00:31:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060111233118.GA1534@elf.ucw.cz>
References: <43C53DA0.60704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C53DA0.60704@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The comments desired are (1) do the helper routines in xen_sysfs 
> duplicate code already present in linux (or under development somewhere 
> else). (2) Is it appropriate for a process to create sysfs attributes 
> without implementing a driver subsystem

Not sure, maybe proc is really better.

> or (3) are such attributes 
> better off living under /proc. (4) any other feedback is appreciated.

> --- a/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
> 17:53:44 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/Makefile     Tue Jan 10 
> 23:30:37 2006

Your mailer is evil and word-wraps patches.

> +#ifndef BOOL
> +#define BOOL    int
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE   0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE    1
> +#endif
> +
> +#ifndef NULL
> +#define NULL    0
> +#endif

Evil!
								Pavel

> +{
> +       struct xen_sysfs_object * xen_obj = to_xen_obj_bin(kobj);
> +       if (xen_obj->attr.write)
> +               return xen_obj->attr.write(xen_obj->user_data, buf, 
> offset, size);
> +       if(size == 0 )

CodingStyle...
> +       .path = __stringify(/sys/xen),

Eh?

> +       .list = LIST_HEAD_INIT(xen_root.list),
> +       .children = LIST_HEAD_INIT(xen_root.children),
> +       .parent = NULL,
> +};
> +
> +/* xen sysfs path functions */
> +
> +static BOOL
> +valid_chars(const char *path)
> +{
> +       if( ! strstarts(path, "/sys/xen") )
> +               return FALSE;
> +       if(strstr(path, "//"))
> +               return FALSE;
> +       return (strspn(path,
> +                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +                      "abcdefghijklmnopqrstuvwxyz"
> +                      "0123456789-/_@~$") == strlen(path));
> +}
> +
> +
> +/* return value must be kfree'd */
> +static char *
> +dup_path(const char *path)
> +{
> +       char * ret;
> +       int len;
> +       BUG_ON( ! path );
> +
> +       if( FALSE == valid_chars(path) ) {
> +               return NULL;
> +       }
> +
> +       len = strlen(path) + 1;
> +       ret = kcalloc(len - 1, sizeof(char), GFP_KERNEL);
> +       memcpy(ret, path, len);
> +       return ret;
> +}
> +
> +
> +
> +static char *
> +basename(const char *name)
> +{
> +       return strrchr(name, '/') + 1;
> +}
> +
> +static char *
> +strip_trailing_slash(char * path)
> +{
> +       int len = strlen(path);
> +
> +       char * term = path + len - 1;
> +       if( *term == '/')
> +               *term = 0;
> +       return path;
> +}
> +
> +/* return value must be kfree'd */
> +static char * dirname(const char * name)
> +{
> +       char *ret;
> +       int len;
> +
> +       len = strlen(name) - strlen(basename(name)) + 1;
> +       ret = kcalloc(len, sizeof(char), GFP_KERNEL);
> +       memcpy(ret, name, len - 1);
> +       ret = strip_trailing_slash(ret);
> +
> +       return ret;
> +}
> +
> +
> +/* type must be char, bin, or dir */
> +static __sysfs_ref__ struct xen_sysfs_object *
> +new_sysfs_object(const char * path,
> +                int type,
> +                int mode,
> +                ssize_t (*show)(void *, char *),
> +                ssize_t (*store)(void *, const char *, size_t),
> +                ssize_t (*read)(void *, char *, loff_t, size_t),
> +                ssize_t (*write)(void *, char *, loff_t, size_t),
> +                void * user_data,
> +                void (* user_data_release)(void *))
> +{
> +       struct xen_sysfs_object * ret =
> +               (struct xen_sysfs_object *)kcalloc(sizeof(struct 
> xen_sysfs_object),
> +                                                  sizeof(char),
> +                                                  GFP_KERNEL);

Unneeded cast AFAICT.

> +       // if path is longer than obj-path, search children
> +       if ( strstarts(path, obj->path) &&

Mo C++ comments please.
						Pavel
-- 
Thanks, Sharp!
