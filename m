Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWA1DDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWA1DDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWA1DDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:03:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:41708 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751236AbWA1DDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:03:23 -0500
Message-ID: <43DADEF5.7030502@us.ibm.com>
Date: Fri, 27 Jan 2006 21:03:17 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mike D. Day" <ncmike@us.ibm.com>
CC: xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 2.6.12.6-xen] sysfs attributes for xen
References: <43DAD4DB.4090708@us.ibm.com>
In-Reply-To: <43DAD4DB.4090708@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inlined.

Mike D. Day wrote:

> Creates /sys/hypervisor/xen and populates that dir with xen version, 
> changeset, compilation, and capabilities info. Intended for the xen 
> merge tree and later upstream.

<snip>

> +    if( 0 ==  (err = subsystem_register(&hypervisor_subsys)) ) {

This formatting is off.  You want a space after the if and no space 
after the (.  See CodingStyle.  It could be your mailer (it munged the 
newlines) but it appears you've got 4 space tabs?  Linux style is 8.

> +        if( ! HYPERVISOR_xen_version(XENVER_extraversion, 
> +                        extra_version) ) {
> +            page[PAGE_SIZE - 1] = 0x00;
> +            return snprintf(page, PAGE_SIZE - 1, +                    
> "xen-%ld.%ld%s\n",
> +                    major, minor, extra_version);

snprintf takes into account the terminating byte so you don't have to.

<snip>

> +/* xen compile info */
> +static ssize_t xen_compile_show(struct kobject * kobj, 
> +                struct attribute * attr, +                char * page)
> +{
> +    struct xen_compile_info info;
> +   
> +    if( 0 == HYPERVISOR_xen_version(XENVER_compile_info, &info) ) {
> +        page[PAGE_SIZE - 1] = 0x00;
> +        return snprintf(page, PAGE_SIZE - 1, +                
> "compiled by %s, using %s, on %s\n", +                info.compile_by, 
> +                info.compile_date, +                info.compiler);
> +    }
> +    return 0;
> +}

I'm not the best person to speak to this but I'm pretty sure sysfs 
prefers single values per file so you probably want to split this up 
into compile_by, compile_date, compiler.

> +int __init
> +sysfs_xen_version_init(void)
> +{
> +    __label__  out;
> +   
> +    struct kset * parent = get_xen_kset();
> +    if ( parent != NULL ) {
> +        kobject_init(&xen_ver_obj);
> +        xen_ver_obj.parent = &parent->kobj;       
> +        xen_ver_obj.dentry = parent->kobj.dentry;
> +        kobject_get(&parent->kobj);
> +        if ( sysfs_create_file(&xen_ver_obj, &xen_ver_attr.attr) )
> +            goto out;

I reckon you want to use default attributes here instead of immediately 
calling sysfs_create_file().

Regards,

Anthony Liguori
