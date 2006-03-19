Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWCSPay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWCSPay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCSPay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:30:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14233 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932128AbWCSPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:30:53 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
References: <20060306235248.20842700@localhost.localdomain>
	<20060306235249.880CB28A@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 08:29:24 -0700
In-Reply-To: <20060306235249.880CB28A@localhost.localdomain> (Dave Hansen's
 message of "Mon, 06 Mar 2006 15:52:49 -0800")
Message-ID: <m1veuawizv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Right now, sysctls can only deal with global variables.  This
> patch makes them a _little_ more flexible by allowing there to
> be an accessor function to get at the variable being changed,
> instead of it being global.
>
> This allows the sysctls to be backed by variables that are,
> for instance, dynamically allocated and not available at
> compile-time.
>
> This also provides a very simple mechanism to take things that
> are currently global and containerize them.

Sorry for taking so long to look at this I just spotted this
series of patches.

The parameters that describe the variable are:
data, maxlen, extra1, and extra2.

I am concerned that this does not provide a capability for
anything except data to vary at runtime.

Also so that we can do a good job and report process local resources
in /proc this data_access should take a task_struct parameter.

data_access should also be passed the the ctl_table in case
we can make an generic data accessor.

That would allow us to put offsetof is data and then
simply add currrent->ipc_context to get the address of
the variable.  Which should keep the number of accessor functions
down.

Which give a signature something like:

struct ctl_data_info {
       void *data;
       int maxlen;
       void *extra1;
       void *extra2;
};

void ctl_data_access(struct ctl_table *tbl, sruct task_struct *task, 
			struct ctl_data_info *info);


> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> ---
>
>  work-dave/include/linux/sysctl.h |    8 ++++
>  work-dave/kernel/sysctl.c | 65 ++++++++++++++++++++++++++-------------
>  2 files changed, 52 insertions(+), 21 deletions(-)
>
> diff -puN include/linux/sysctl.h~sysctls-for-containers include/linux/sysctl.h
> --- work/include/linux/sysctl.h~sysctls-for-containers 2006-03-06
> 15:41:55.000000000 -0800
> +++ work-dave/include/linux/sysctl.h	2006-03-06 15:41:55.000000000 -0800
> @@ -872,6 +872,7 @@ extern void sysctl_init(void);
>  
>  typedef struct ctl_table ctl_table;
>  
> +typedef void *ctl_data_access (void);
>  typedef int ctl_handler (ctl_table *table, int __user *name, int nlen,
>  			 void __user *oldval, size_t __user *oldlenp,
>  			 void __user *newval, size_t newlen, 
> @@ -957,6 +958,13 @@ struct ctl_table 
>  	int ctl_name;			/* Binary ID */
>  	const char *procname;		/* Text ID for /proc/sys, or zero */
>  	void *data;
> +	ctl_data_access *data_access;	/* set this to a function if you
> +					 * don't have a static place to point
> +					 * ->data at compile-time.  This
> + * function will be called to dynamically
> +					 * figure out a ->data pointer.  Do not
> +					 * set this and ->data at once.
> +					 */
>  	int maxlen;
>  	mode_t mode;
>  	ctl_table *child;
> diff -puN kernel/sysctl.c~sysctls-for-containers kernel/sysctl.c
> --- work/kernel/sysctl.c~sysctls-for-containers 2006-03-06 15:41:55.000000000
> -0800
> +++ work-dave/kernel/sysctl.c	2006-03-06 15:41:55.000000000 -0800
> @@ -1197,6 +1197,24 @@ repeat:
>  	return -ENOTDIR;
>  }
>  
> +void *sysctl_table_data(ctl_table *table)
> +{
> +	void *data;
> +
> +	if (table->data && table->data_access) {
> +		printk(KERN_WARNING
> +			"sysctl: data and accessor function set for: '%s'\n",
> +			table->procname);
> +		table->data = NULL;
> +	}
> +
> +	data = table->data;
> +	if (!data && table->data_access)
> +		data = table->data_access();
> +
> +	return data;
> +}

I think we should always call data_access if it is populated.

For the rest it looks like it is getting there.

Eric
