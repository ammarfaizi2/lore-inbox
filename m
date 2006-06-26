Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933320AbWFZWtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbWFZWtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933349AbWFZWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:49:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:18606 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933327AbWFZWtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:49:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 2/2] [Suspend2] Freezer upgrade.
Date: Tue, 27 Jun 2006 08:48:51 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <20060626163856.10345.14073.stgit@nigel.suspend2.net> <200606262201.09687.rjw@sisk.pl>
In-Reply-To: <200606262201.09687.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3140082.IzLASC18gB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606270848.55475.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3140082.IzLASC18gB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 06:01, Rafael J. Wysocki wrote:
> Hi,
>
> On Monday 26 June 2006 18:38, Nigel Cunningham wrote:
> > This patch represents the Suspend2 upgrades to the freezer
> > implementation. Due to recent changes in the vanilla version, I should =
be
> > able to greatly reduce the size of this patch. TODO.
>
> So I assume the patch will change in the future.

This is after the changes. Sorry - forgot to update the comment.

> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> >
> >  include/linux/freezer.h |   29 +++++++++++
> >  include/linux/sched.h   |    4 +
> >  include/linux/suspend.h |    5 ++
> >  kernel/kmod.c           |    4 +
> >  kernel/power/disk.c     |    5 +-
> >  kernel/power/main.c     |    5 +-
> >  kernel/power/process.c  |  127
> > ++++++++++++++++++++++++++++++++++++++++------- kernel/power/swsusp.c  =
 |
> >    5 ++
> >  kernel/power/user.c     |    7 +--
> >  9 files changed, 164 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > new file mode 100644
> > index 0000000..43ef3b2
> > --- /dev/null
> > +++ b/include/linux/freezer.h
> > @@ -0,0 +1,29 @@
> > +/* Freezer declarations */
> > +
> > +#define FREEZER_ON 0
> > +#define ABORT_FREEZING 1
> > +#define FREEZING_COMPLETE 2
> > +
> > +#define FREEZER_KERNEL_THREADS 0
> > +#define FREEZER_ALL_THREADS 1
>
> I think these need some comments.  It's not clear to me why you need them,
> actually.

Ok.

> > +
> > +#ifdef CONFIG_PM
> > +extern unsigned long freezer_state;
> > +
> > +#define test_freezer_state(bit) test_bit(bit, &freezer_state)
> > +#define set_freezer_state(bit) set_bit(bit, &freezer_state)
> > +#define clear_freezer_state(bit) clear_bit(bit, &freezer_state)
> > +
> > +#define freezer_is_on() (test_freezer_state(FREEZER_ON))
> > +
> > +extern void do_freeze_process(struct notifier_block *nl);
>
> Ditto.

do_freeze_process should go. It's a cleanup I missed when I stopped using=20
Christoph's todo list code.

> > +
> > +#else
> > +
> > +#define test_freezer_state(bit) (0)
> > +#define set_freezer_state(bit) do { } while(0)
> > +#define clear_freezer_state(bit) do { } while(0)
> > +
> > +#define freezer_is_on() (0)
> > +
> > +#endif
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 267f152..b6d96ab 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1452,7 +1452,7 @@ static inline void frozen_process(struct
> >
> >  extern void refrigerator(void);
> >  extern int freeze_processes(void);
> > -extern void thaw_processes(void);
> > +extern void thaw_processes(int which_threads);
> >
> >  static inline int try_to_freeze(void)
> >  {
> > @@ -1471,7 +1471,7 @@ static inline void frozen_process(struct
> >
> >  static inline void refrigerator(void) {}
> >  static inline int freeze_processes(void) { BUG(); return 0; }
> > -static inline void thaw_processes(void) {}
> > +static inline void thaw_processes(int which_threads) {}
>
> I'd probably try to introduce two different functions like
> thaw_user_processes() and thaw_kernel_threads() instead of this.  Even if
> they called the same routine internally, it would be clear what they were
> for.

Ok. I was just trying to minimise the delta, so I don't mind this idea at a=
ll.
thaw_user_processes() would imply thawing kernel threads in the logic I hav=
e=20
at the moment. Would calling it thaw_processes() instead sound ok?

> BTW, this also affects the suspend-to-RAM, at least on some architectures.

I'll double check for other refrigerator calls then.

> >  static inline int try_to_freeze(void) { return 0; }
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 96e31aa..b128fd2 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/notifier.h>
> >  #include <linux/init.h>
> >  #include <linux/pm.h>
> > +#include <linux/suspend2.h>
> >
> >  /* page backup entry */
> >  typedef struct pbe {
> > @@ -45,6 +46,8 @@ extern int software_suspend(void);
> >  #if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
> >  extern int pm_prepare_console(void);
> >  extern void pm_restore_console(void);
> > +extern int freeze_processes(void);
> > +extern void thaw_processes(int which_threads);
> >  #else
> >  static inline int pm_prepare_console(void) { return 0; }
> >  static inline void pm_restore_console(void) {}
> > @@ -55,6 +58,8 @@ static inline int software_suspend(void)
> >  	printk("Warning: fake suspend called\n");
> >  	return -EPERM;
> >  }
> > +static inline int freeze_processes(void) { return 0; }
> > +static inline void thaw_processes(int which_threads) { }
> >  #endif /* CONFIG_PM */
> >
> >  #ifdef CONFIG_SUSPEND_SMP
> > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > index 20a997c..b792b32 100644
> > --- a/kernel/kmod.c
> > +++ b/kernel/kmod.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > +#include <linux/freezer.h>
> >  #include <asm/uaccess.h>
> >
> >  extern int max_threads;
> > @@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
> >  	if (!khelper_wq)
> >  		return -EBUSY;
> >
> > +	if (freezer_is_on())
> > +		return 0;
> > +
> >  	if (path[0] =3D=3D '\0')
> >  		return 0;
>
> I'm not sure if I agree with this change.  AFAIR, this was discussed some
> time ago with no specific conclusion, but at least some people argued it
> wouldn't be right to do so.  Could you please provide some arguments?

Yes, I don't remember a specific conclusion either. I'm more than happy to =
see=20
something else happen. I can just report that this has been used for quite =
a=20
while with no negative reports. It would be good to use this as provocation=
=20
to come up with a clear agreement on the right way.

> > diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> > index 81d4d98..a2463e3 100644
> > --- a/kernel/power/disk.c
> > +++ b/kernel/power/disk.c
> > @@ -10,6 +10,7 @@
> >   */
> >
> >  #include <linux/suspend.h>
> > +#include <linux/freezer.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/reboot.h>
> >  #include <linux/string.h>
> > @@ -83,7 +84,7 @@ static int prepare_processes(void)
> >  	if (!(error =3D swsusp_shrink_memory()))
> >  		return 0;
> >  thaw:
> > -	thaw_processes();
> > +	thaw_processes(FREEZER_ALL_THREADS);
> >  	enable_nonboot_cpus();
> >  	pm_restore_console();
> >  	return error;
> > @@ -92,7 +93,7 @@ thaw:
> >  static void unprepare_processes(void)
> >  {
> >  	platform_finish();
> > -	thaw_processes();
> > +	thaw_processes(FREEZER_ALL_THREADS);
> >  	enable_nonboot_cpus();
> >  	pm_restore_console();
> >  }
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 0a907f0..8413db2 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #include <linux/suspend.h>
> > +#include <linux/freezer.h>
> >  #include <linux/kobject.h>
> >  #include <linux/string.h>
> >  #include <linux/delay.h>
> > @@ -96,7 +97,7 @@ static int suspend_prepare(suspend_state
> >  	if (pm_ops->finish)
> >  		pm_ops->finish(state);
> >   Thaw:
> > -	thaw_processes();
> > +	thaw_processes(FREEZER_ALL_THREADS);
> >   Enable_cpu:
> >  	enable_nonboot_cpus();
> >  	pm_restore_console();
> > @@ -135,7 +136,7 @@ static void suspend_finish(suspend_state
> >  {
> >  	device_resume();
> >  	resume_console();
> > -	thaw_processes();
> > +	thaw_processes(FREEZER_ALL_THREADS);
> >  	enable_nonboot_cpus();
> >  	if (pm_ops && pm_ops->finish)
> >  		pm_ops->finish(state);
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index b2a5f67..020895d 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -5,7 +5,6 @@
> >   * Originally from swsusp.
> >   */
> >
> > -
> >  #undef DEBUG
> >
> >  #include <linux/smp_lock.h>
> > @@ -13,12 +12,72 @@
> >  #include <linux/suspend.h>
> >  #include <linux/module.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/buffer_head.h>
> > +#include <linux/freezer.h>
> > +
> > +unsigned long freezer_state =3D 0;
> > +
> > +#ifdef CONFIG_PM_DEBUG
> > +#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
> > +#else
> > +#define freezer_message(msg, a...) do { } while(0)
> > +#endif
> >
> >  /*
> >   * Timeout for stopping processes
> >   */
> >  #define TIMEOUT	(20 * HZ)
> >
> > +struct frozen_fs
> > +{
> > +	struct list_head fsb_list;
> > +	struct super_block *sb;
> > +};
> > +
> > +LIST_HEAD(frozen_fs_list);
> > +
> > +void freezer_make_fses_rw(void)
> > +{
> > +	struct frozen_fs *fs, *next_fs;
> > +
> > +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> > +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> > +
> > +		list_del(&fs->fsb_list);
> > +		kfree(fs);
> > +	}
> > +}
> > +
> > +/*
> > + * Done after userspace is frozen, so there should be no danger of
> > + * fses being unmounted while we're in here.
> > + */
> > +int freezer_make_fses_ro(void)
> > +{
> > +	struct frozen_fs *fs;
> > +	struct super_block *sb;
> > +
> > +	/* Generate the list */
> > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > +		if (!sb->s_root || !sb->s_bdev ||
> > +		    (sb->s_frozen =3D=3D SB_FREEZE_TRANS) ||
> > +		    (sb->s_flags & MS_RDONLY))
> > +			continue;
> > +
> > +		fs =3D kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
>
> Are you _sure_ fs will be !=3D0 here?

Thanks. I'll add a check. I know never having seen it fail doesn't mean it=
=20
can't :)

> > +		fs->sb =3D sb;
> > +		list_add_tail(&fs->fsb_list, &frozen_fs_list);
> > +	};
> > +
> > +	/* Do the freezing in reverse order so filesystems dependant
> > +	 * upon others are frozen in the right order. (Eg loopback
> > +	 * on ext3). */
> > +	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
> > +		freeze_bdev(fs->sb->s_bdev);
> > +
> > +	return 0;
> > +}
> > +
> >
> >  static inline int freezeable(struct task_struct * p)
> >  {
> > @@ -39,7 +98,7 @@ void refrigerator(void)
> >  	long save;
> >  	save =3D current->state;
> >  	pr_debug("%s entered refrigerator\n", current->comm);
> > -	printk("=3D");
> > +	freezer_message("=3D");
>
> Where is it defined?

At the top of the file.

> >  	frozen_process(current);
> >  	spin_lock_irq(&current->sighand->siglock);
> > @@ -74,9 +133,13 @@ int freeze_processes(void)
> >  	struct task_struct *g, *p;
> >  	unsigned long flags;
> >
> > -	printk( "Stopping tasks: " );
> > +	user_frozen =3D test_freezer_state(FREEZER_ON);
> > +
> > +	if (!user_frozen)
> > +		set_freezer_state(FREEZER_ON);
>
> I'm not quite sure it needs to be done this way.

We want this path to handle two situations. First, where nothing is frozen =
and=20
second, where userspace is already frozen. In the second case, we don't wan=
t=20
to try to freeze userspace all over again (we'll deadlock for a start), and=
=20
we also don't want to try to freeze bdevs again (another cause for=20
deadlocking).

> > +
> > +	freezer_message( "Stopping tasks: " );
> >  	start_time =3D jiffies;
> > -	user_frozen =3D 0;
> >  	do {
> >  		nr_user =3D todo =3D 0;
> >  		read_lock(&tasklist_lock);
> > @@ -103,8 +166,10 @@ int freeze_processes(void)
> >  		read_unlock(&tasklist_lock);
> >  		todo +=3D nr_user;
> >  		if (!user_frozen && !nr_user) {
> > -			sys_sync();
> > +			freezer_message("Freezing bdevs... ");
> > +			freezer_make_fses_ro();
> >  			start_time =3D jiffies;
> > +			freezer_message("Freezing kernel threads... ");
> >  		}
> >  		user_frozen =3D !nr_user;
> >  		yield();			/* Yield is okay here */
> > @@ -118,14 +183,14 @@ int freeze_processes(void)
> >  	 * but it cleans up leftover PF_FREEZE requests.
> >  	 */
> >  	if (todo) {
> > -		printk( "\n" );
> > -		printk(KERN_ERR " stopping tasks timed out "
> > +		freezer_message( "\n" );
> > +		freezer_message(KERN_ERR " stopping tasks timed out "
> >  			"after %d seconds (%d tasks remaining):\n",
> >  			TIMEOUT / HZ, todo);
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> >  			if (freezeable(p) && !frozen(p))
> > -				printk(KERN_ERR "  %s\n", p->comm);
> > +				freezer_message(KERN_ERR "  %s\n", p->comm);
> >  			if (freezing(p)) {
> >  				pr_debug("  clean up: %s\n", p->comm);
> >  				p->flags &=3D ~PF_FREEZE;
> > @@ -138,27 +203,53 @@ int freeze_processes(void)
> >  		return todo;
> >  	}
> >
> > -	printk( "|\n" );
> > +	freezer_message( "|\n" );
> >  	BUG_ON(in_atomic());
> > +
> > +	set_freezer_state(FREEZING_COMPLETE);
> > +
> >  	return 0;
> >  }
> >
> > -void thaw_processes(void)
> > +void thaw_processes(int all)
> >  {
> >  	struct task_struct *g, *p;
> > +	int pass =3D 0; /* Start on kernel space */
> > +
> > +	if (!test_freezer_state(FREEZER_ON))
> > +		return;
> > +
> > +	if (!test_freezer_state(FREEZING_COMPLETE))
> > +		pass++;
> > +
> > +	clear_freezer_state(FREEZING_COMPLETE);
> >
> > -	printk( "Restarting tasks..." );
> > +	freezer_message( "Restarting tasks..." );
> >  	read_lock(&tasklist_lock);
> > -	do_each_thread(g, p) {
> > -		if (!freezeable(p))
> > -			continue;
> > -		if (!thaw_process(p))
> > -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > -	} while_each_thread(g, p);
> > +	do {
> > +		if (pass) {
> > +			read_unlock(&tasklist_lock);
> > +			freezer_make_fses_rw();
> > +			read_lock(&tasklist_lock);
> > +		}
> > +
> > +		do_each_thread(g, p) {
> > +			int is_user =3D !!(p->mm && !(p->flags & PF_BORROWED_MM));
> > +			if (!freezeable(p) || (is_user !=3D pass))
>
> Well, this test looks a bit too convoluted, so to speak. ;-)

It needs to be readable too?! I'd better submit patches for some other bits=
 of=20
the kernel too then! :). Seriously, though, pass =3D=3D 0 if we're thawing =
kernel=20
threads or 1 if userspace. Would adding a comment to this effect make you=20
happy?

> > +				continue;
> > +			if (!thaw_process(p))
> > +				freezer_message(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > +		} while_each_thread(g, p);
> > +
> > +		pass++;
> > +	} while(pass < 2 && all);
> >
> >  	read_unlock(&tasklist_lock);
> >  	schedule();
> > -	printk( " done\n" );
> > +	freezer_message( " done\n" );
> > +
> > +	if (all)
> > +		clear_freezer_state(FREEZER_ON);
> >  }
> >
> >  EXPORT_SYMBOL(refrigerator);
> > diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> > index c4016cb..64acda1 100644
> > --- a/kernel/power/swsusp.c
> > +++ b/kernel/power/swsusp.c
> > @@ -49,6 +49,7 @@
> >  #include <linux/bootmem.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/highmem.h>
> > +#include <linux/freezer.h>
> >
> >  #include "power.h"
> >
> > @@ -184,6 +185,8 @@ int swsusp_shrink_memory(void)
> >  	unsigned int i =3D 0;
> >  	char *p =3D "-\\|/";
> >
> > +	thaw_processes(FREEZER_KERNEL_THREADS);
> > +
>
> Could you please explain why you think that we should thaw the kernel
> threads here?

IIRC, there are deadlocking issues if swap is on a journalled filesystem an=
d=20
the kjournald et al are frozen.

> >  	printk("Shrinking memory...  ");
> >  	do {
> >  		size =3D 2 * count_highmem_pages();
> > @@ -207,6 +210,8 @@ int swsusp_shrink_memory(void)
> >  	} while (tmp > 0);
> >  	printk("\bdone (%lu pages freed)\n", pages);
> >
> > +	freeze_processes();
> > +
> >  	return 0;
> >  }
> >
> > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > index 3f1539f..10d5c9b 100644
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/swapops.h>
> >  #include <linux/pm.h>
> >  #include <linux/fs.h>
> > +#include <linux/freezer.h>
> >
> >  #include <asm/uaccess.h>
> >
> > @@ -75,7 +76,7 @@ static int snapshot_release(struct inode
> >  	free_bitmap(data->bitmap);
> >  	if (data->frozen) {
> >  		down(&pm_sem);
> > -		thaw_processes();
> > +		thaw_processes(FREEZER_ALL_THREADS);
>
> I'd prefer if you defined:
>
>  thaw_processes() {
> 	thaw_kernel_threads();
> 	thaw_user_processes();
> }
>
> so that this change (and the next two) were not necessary.

Ok. I'll wait to see if you like the suggestion above before I start to do=
=20
that.

> Also, I think we could try to merge the freezing of bdevs independently if
> you can provide a test case in which it is really necessary.

XFS. Did you see Nathan's reply not long ago, confirming that it doesn't st=
op=20
all activity if you don't freeze bdevs? That isn't critical for swsusp=20
(although I guess you could end up with some filesystem inconsistency if XF=
S=20
writes something after the atomic copy), but keeping the LRU static is=20
important for suspend2.

> >  		enable_nonboot_cpus();
> >  		up(&pm_sem);
> >  	}
> > @@ -141,7 +142,7 @@ static int snapshot_ioctl(struct inode *
> >  		down(&pm_sem);
> >  		disable_nonboot_cpus();
> >  		if (freeze_processes()) {
> > -			thaw_processes();
> > +			thaw_processes(FREEZER_ALL_THREADS);
> >  			enable_nonboot_cpus();
> >  			error =3D -EBUSY;
> >  		}
> > @@ -154,7 +155,7 @@ static int snapshot_ioctl(struct inode *
> >  		if (!data->frozen)
> >  			break;
> >  		down(&pm_sem);
> > -		thaw_processes();
> > +		thaw_processes(FREEZER_ALL_THREADS);
> >  		enable_nonboot_cpus();
> >  		up(&pm_sem);
> >  		data->frozen =3D 0;
> >
> > --

Thanks very much for the feedback!

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart3140082.IzLASC18gB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoGRXN0y+n1M3mo0RAj/GAJ0Wzyf1AuVJcRhkB/BUqQsRajpvXQCgwSuO
SR3yo9Z71rzuNeMsjeegXXw=
=eW7b
-----END PGP SIGNATURE-----

--nextPart3140082.IzLASC18gB--
