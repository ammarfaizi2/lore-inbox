Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRAMS0A>; Sat, 13 Jan 2001 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRAMSZk>; Sat, 13 Jan 2001 13:25:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131157AbRAMSZX>;
	Sat, 13 Jan 2001 13:25:23 -0500
Date: Sat, 13 Jan 2001 08:43:17 -0700
From: yodaiken@fsmlabs.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010113084317.B12009@hq.fsmlabs.com>
In-Reply-To: <3A5C2034.537B4C58@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A5C2034.537B4C58@colorfullife.com>; from Manfred Spraul on Wed, Jan 10, 2001 at 09:41:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW: POSIX mq_send does not promise that the buffer is safe, it only
promises that the message is queued. Interesting interface.



On Wed, Jan 10, 2001 at 09:41:24AM +0100, Manfred Spraul wrote:
> > > In user space, how do you know when its safe to reuse the buffer that 
> > > was handed to sendmsg() with the MSG_NOCOPY flag? Or does sendmsg() 
> > > with that flag block until the buffer isn't needed by the kernel any 
> > > more? If it does block, doesn't that defeat the use of non-blocking 
> > > I/O? 
> > 
> > sendmsg() marks those pages COW and copies the original page into a new 
> > one for further usage. (the old page is used until the packet is 
> > released.) So for maximum performance user-space should not reuse such 
> > buffers immediately. 
> >
> That means sendmsg() changes the page tables? I measures
> smp_call_function on my Dual Pentium 350, and it took around 1950 cpu
> ticks.
> I'm sure that for an 8 way server the total lost time on all cpus (multi
> threaded server) is larger than the time required to copy the complete
> page.
> (I've attached my patch, just run "insmod dummy p_shift=0")
> 
> 
> --
> 	Manfred
> --- 2.4/drivers/net/dummy.c	Mon Dec  4 02:45:22 2000
> +++ build-2.4/drivers/net/dummy.c	Wed Jan 10 09:15:20 2001
> @@ -95,9 +95,168 @@
>  
>  static struct net_device dev_dummy;
>  
> +/* ************************************* */
> +int p_shift = -1;
> +MODULE_PARM     (p_shift, "1i");
> +MODULE_PARM_DESC(p_shift, "Shift for the profile buffer");
> +
> +int p_size = 0;
> +MODULE_PARM     (p_size, "1i");
> +MODULE_PARM_DESC(p_size, "size");
> +
> +
> +#define STAT_TABLELEN		16384
> +static unsigned long totals[STAT_TABLELEN];
> +static unsigned int overflows;
> +
> +static unsigned long long stime;
> +static void start_measure(void)
> +{
> +	 __asm__ __volatile__ (
> +		".align 64\n\t"
> +	 	"pushal\n\t"
> +		"cpuid\n\t"
> +		"popal\n\t"
> +		"rdtsc\n\t"
> +		"movl %%eax,(%0)\n\t"
> +		"movl %%edx,4(%0)\n\t"
> +		: /* no output */
> +		: "c"(&stime)
> +		: "eax", "edx", "memory" );
> +}
> +
> +static void end_measure(void)
> +{
> +static unsigned long long etime;
> +	__asm__ __volatile__ (
> +		"pushal\n\t"
> +		"cpuid\n\t"
> +		"popal\n\t"
> +		"rdtsc\n\t"
> +		"movl %%eax,(%0)\n\t"
> +		"movl %%edx,4(%0)\n\t"
> +		: /* no output */
> +		: "c"(&etime)
> +		: "eax", "edx", "memory" );
> +	{
> +		unsigned long time = (unsigned long)(etime-stime);
> +		time >>= p_shift;
> +		if(time < STAT_TABLELEN) {
> +			totals[time]++;
> +		} else {
> +			overflows++;
> +		}
> +	}
> +}
> +
> +static void clean_buf(void)
> +{
> +	memset(totals,0,sizeof(totals));
> +	overflows = 0;
> +}
> +
> +static void print_line(unsigned long* array)
> +{
> +	int i;
> +	for(i=0;i<32;i++) {
> +		if((i%32)==16)
> +			printk(":");
> +		printk("%lx ",array[i]); 
> +	}
> +}
> +
> +static void print_buf(char* caption)
> +{
> +	int i, other = 0;
> +	printk("Results - %s - shift %d",
> +		caption, p_shift);
> +
> +	for(i=0;i<STAT_TABLELEN;i+=32) {
> +		int j;
> +		int local = 0;
> +		for(j=0;j<32;j++)
> +			local += totals[i+j];
> +
> +		if(local) {
> +			printk("\n%3x: ",i);
> +			print_line(&totals[i]);
> +			other += local;
> +		}
> +	}
> +	printk("\nOverflows: %d.\n",
> +		overflows);
> +	printk("Sum: %ld\n",other+overflows);
> +}
> +
> +static void return_immediately(void* dummy)
> +{
> +	return;
> +}
> +
> +static void just_one_page(void* dummy)
> +{
> +	__flush_tlb_one(0x12345678);
> +	return;
> +}
> +
> +
>  static int __init dummy_init_module(void)
>  {
>  	int err;
> +
> +	if(p_shift != -1) {
> +		int i;
> +		void* p;
> +		kmem_cache_t* cachep;
> +		/* empty test measurement: */
> +		printk("******** kernel cpu benchmark started **********\n");
> +		clean_buf();
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(200);
> +		for(i=0;i<100;i++) {
> +			start_measure();
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			end_measure();
> +		}
> +		print_buf("zero");
> +		clean_buf();
> +
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(200);
> +		for(i=0;i<100;i++) {
> +			start_measure();
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			smp_call_function(return_immediately,NULL,
> +						1, 1);
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			end_measure();
> +		}
> +		print_buf("empty smp_call_function()");
> +		clean_buf();
> +
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(200);
> +		for(i=0;i<100;i++) {
> +			start_measure();
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			smp_call_function(just_one_page,NULL,
> +						1, 1);
> +			just_one_page(NULL);
> +			return_immediately(NULL);
> +			return_immediately(NULL);
> +			end_measure();
> +		}
> +		print_buf("flush_one_page()");
> +		clean_buf();	
> +
> +		return -EINVAL;
> +	}
>  
>  	dev_dummy.init = dummy_init;
>  	SET_MODULE_OWNER(&dev_dummy);
> 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
