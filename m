Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbTC2WVQ>; Sat, 29 Mar 2003 17:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263486AbTC2WVQ>; Sat, 29 Mar 2003 17:21:16 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:2052
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263485AbTC2WVN>; Sat, 29 Mar 2003 17:21:13 -0500
Message-ID: <007201c2f643$2bb18090$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
References: <001c01c2f634$2e517da0$030aa8c0@unknown><1048972543.13757.3.camel@localhost><004201c2f63c$25d4aa00$030aa8c0@unknown> <20030329142835.40fa8eb9.akpm@digeo.com>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
Date: Sat, 29 Mar 2003 17:33:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applying this now.

----- Original Message -----
From: "Andrew Morton" <akpm@digeo.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: <rml@tech9.net>; <linux-kernel@vger.kernel.org>
Sent: Saturday, March 29, 2003 5:28 PM
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings


> "Shawn Starr" <spstarr@sh0n.net> wrote:
> >
> > How can I go about debugging this? How can I find the path causing the
> > problem?
> >
>
> Someone did
>
> kfree(foo);
>
> insead of
>
> del_timer_sync(&foo->timer);
> kfree(foo);
>
> so you have a freed-but-pending timer.
>
>
> This is a horrid bug.  One way to find it would be to change
> cache_free_debugcheck() to walk the just-freed-up memory looking for an
> instance of TIMER_MAGIC.  If that is found and timer_pending() is true
then
> drop a backtrace and print out timer->function.
>
> err....  Here you go, this may find it.
>
>
>
>  fs/open.c             |   33 +++++++++++++++++++++++++++++++++
>  include/linux/timer.h |    3 ++-
>  mm/slab.c             |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 1 deletion(-)
>
> diff -puN include/linux/timer.h~freed-timer-finder include/linux/timer.h
> --- 25/include/linux/timer.h~freed-timer-finder 2003-03-29
14:10:15.000000000 -0800
> +++ 25-akpm/include/linux/timer.h 2003-03-29 14:10:26.000000000 -0800
> @@ -8,11 +8,12 @@
>  struct tvec_t_base_s;
>
>  struct timer_list {
> + unsigned long magic;
> +
>   struct list_head entry;
>   unsigned long expires;
>
>   spinlock_t lock;
> - unsigned long magic;
>
>   void (*function)(unsigned long);
>   unsigned long data;
> diff -puN mm/slab.c~freed-timer-finder mm/slab.c
> --- 25/mm/slab.c~freed-timer-finder 2003-03-29 14:10:30.000000000 -0800
> +++ 25-akpm/mm/slab.c 2003-03-29 14:16:23.000000000 -0800
> @@ -800,6 +800,35 @@ static void poison_obj(kmem_cache_t *cac
>   *(unsigned char *)(addr+size-1) = POISON_END;
>  }
>
> +static void timer_hunt(kmem_cache_t *cachep, void *addr)
> +{
> + int size = cachep->objsize;
> + void *p;
> +
> + if (cachep->flags & SLAB_RED_ZONE) {
> + addr += BYTES_PER_WORD;
> + size -= 2*BYTES_PER_WORD;
> + }
> + if (cachep->flags & SLAB_STORE_USER) {
> + size -= BYTES_PER_WORD;
> + }
> +
> + for (p = addr; p < addr + size; p += sizeof(unsigned long)) {
> + unsigned long *laddr = p;
> +
> + if (*laddr == TIMER_MAGIC) {
> + struct timer_list *timer;
> +
> + timer = (struct timer_list *)laddr;
> + if (timer_pending(timer)) {
> + printk("free of pending timer at %p\n", timer);
> + printk("function=%p\n", timer->function);
> + dump_stack();
> + }
> + }
> + }
> +}
> +
>  static void *fprob(unsigned char* addr, unsigned int size)
>  {
>   unsigned char *end;
> @@ -1603,6 +1632,7 @@ static inline void *cache_free_debugchec
>   else
>   cachep->dtor(objp, cachep, 0);
>   }
> + timer_hunt(cachep, objp);
>   if (cachep->flags & SLAB_POISON)
>   poison_obj(cachep, objp, POISON_AFTER);
>  #endif
> diff -puN fs/open.c~freed-timer-finder fs/open.c
> --- 25/fs/open.c~freed-timer-finder 2003-03-29 14:17:32.000000000 -0800
> +++ 25-akpm/fs/open.c 2003-03-29 14:21:20.000000000 -0800
> @@ -793,11 +793,44 @@ void fd_install(unsigned int fd, struct
>   write_unlock(&files->file_lock);
>  }
>
> +#include <linux/timer.h>
> +
> +struct foo_thing {
> + int a;
> + struct timer_list t;
> + int b;
> +};
> +
> +static void my_foo(unsigned long data)
> +{
> + printk("the handler\n");
> +}
> +
> +static void timer_thing(void)
> +{
> + static int did_it;
> + struct foo_thing *f;
> +
> + if (did_it)
> + return;
> + did_it = 1;
> +
> + f = kmalloc(sizeof(*f), GFP_KERNEL);
> + init_timer(&f->t);
> + f->t.expires = jiffies + HZ;
> + f->t.function = my_foo;
> + add_timer(&f->t);
> + kfree(f);
> +}
> +
>  asmlinkage long sys_open(const char * filename, int flags, int mode)
>  {
>   char * tmp;
>   int fd, error;
>
> + if (current->uid == 9999)
> + timer_thing();
> +
>  #if BITS_PER_LONG != 32
>   flags |= O_LARGEFILE;
>  #endif
>
> _
>
>

