Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbQLUSsm>; Thu, 21 Dec 2000 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131218AbQLUSsc>; Thu, 21 Dec 2000 13:48:32 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:40862 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131099AbQLUSsY> convert rfc822-to-8bit; Thu, 21 Dec 2000 13:48:24 -0500
From: Heiko.Carstens@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Anton Blanchard <anton@linuxcare.com.au>
cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Message-ID: <C12569BC.0048F80B.00@d12mta01.de.ibm.com>
Date: Thu, 21 Dec 2000 14:16:58 +0100
Subject: Re: CPU attachent and detachment in a running Linux system
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,

>> That's a good point and it would probably work for attachment of cpus,
but
>> it won't work for detachment because there are some data structures that
>> need to be updated if a cpu gets detached. For example it would be nice
>> [...]
>> So at least for detaching it would make sense to register functions
which
>> will be called whenever a cpu gets detached.
>I remember someone from SGI had a patch to merge all the per cpu
structures
>together which would make this easier. It would also save bytes especially
>on machines like the e10k where we must have NR_CPUS = 64.

Thanks for your comment, but I thought of an additional kernel parameter
max_dyn_cpus which would limit the maximum number of cpus that are allowed
to run. This way at least the waste of dynamically allocated memory which
depends on smp_num_cpus will be limited. This could be done by replacing
appropriate occurrences of smp_num_cpus with a macro MAX_DYN_CPUS which
could be defined the following way:

#ifdef CONFIG_DYN_CPU
extern volatile int smp_num_cpus; /* smp_num_cpus may change */
extern int max_dyn_cpus;
#define MAX_DYN_CPUS max_dyn_cpus
#else
extern int smp_num_cpus; /* smp_num_cpus won't change */
#define MAX_DYN_CPUS smp_num_cpus
#endif

Comming back to the question on how to realize an interface where per cpu
dependent parts of the kernel could register a function whenever a cpu gets
detached I think the following approach would work fine:

To register a function the following structure would be used:

typedef struct smp_dyncpu_func_s smp_dyncpu_func_t;
struct smp_dyncpu_func_s {
       void (*f)(int);
       smp_dyncpu_func_t *next;
};


The function which would be called when a function needs to be registered
would look like this:

smp_dyncpu_func_t *dyncpu_func; /* NULL */
...
void smp_register_dyncpu_func(smp_dyncpu_func_t *func)
{
       func->next = dyncpu_func;
       dyncpu_func = func;
       return;
}


And finally every part of the kernel that needs to register a function
which would be used to clean up per cpu data structures would have some
additional code added which would look like this:

static smp_dyncpu_func_t smp_cleanup_func;
...
void local_dyncpu_handler(int killed_cpu){...}
...
static int __init local_dyncpu_init(void)
{
       smp_cleanup_func.f = &local_dyncpu_handler;
       smp_register_dyncpu_func(&smp_cleanup_func);
       return 0;
}
...
__initcall(local_dyncpu_init);

Thinking of modules which may have also per cpu structures there could
be a second function which allows to unregister prior registered
functions.

So what do you think of this approach? I would appreciate any comments
on this.

Best regards,
Heiko


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
