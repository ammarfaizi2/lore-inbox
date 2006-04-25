Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWDYQxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDYQxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDYQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:53:20 -0400
Received: from [84.204.75.166] ([84.204.75.166]:11958 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932226AbWDYQxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:53:18 -0400
Message-ID: <444E53FC.5060100@oktetlabs.ru>
Date: Tue, 25 Apr 2006 20:53:16 +0400
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] GFS2: Mounting & sysfs interface
References: <1145636505.3856.116.camel@quoit.chygwyn.com>
In-Reply-To: <1145636505.3856.116.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse wrote:
> +int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
> +{
> +	int error;
> +
> +	sdp->sd_kobj.kset = &gfs2_kset;
> +	sdp->sd_kobj.ktype = &gfs2_ktype;
> +
> +	error = kobject_set_name(&sdp->sd_kobj, "%s", sdp->sd_table_name);
> +	if (error)
> +		goto fail;
> +
> +	error = kobject_register(&sdp->sd_kobj);
> +	if (error)
> +		goto fail;
> +
> +	error = sysfs_create_group(&sdp->sd_kobj, &lockstruct_group);
> +	if (error)
> +		goto fail_reg;
> +
> +	error = sysfs_create_group(&sdp->sd_kobj, &counters_group);
> +	if (error)
> +		goto fail_lockstruct;
> +
> +	error = sysfs_create_group(&sdp->sd_kobj, &args_group);
> +	if (error)
> +		goto fail_counters;
> +
> +	error = sysfs_create_group(&sdp->sd_kobj, &tune_group);
> +	if (error)
> +		goto fail_args;
> +
> +	return 0;

Hello,

last time I tried to use "bare" sysfs functions to create my sysfs 
hierarchy I ended up with a problem that the module refcount is not 
increased when those sysfs files are opened. So I could open a sysfs 
file from userspace, do rmmod and enjoy oops.

Then I started using the class and class_device stuff, which have an 
.owner field, and all became fine.

I'm not sure if this is a problem of sysfs, but I suspect it could take 
care of module refcount better.

In your patch, I looked for THIS_MODULE pattern and did not find. I did 
not try, but I suspect your code is not devoid of the problem I 
described. So, this is just FYI and may be not the case.

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
