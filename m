Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVBKI4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVBKI4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVBKI4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:56:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:41152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbVBKIzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:55:24 -0500
Date: Fri, 11 Feb 2005 00:54:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org, gh@us.ibm.com,
       elsa-devel@lists.sourceforge.net, greg@kroah.com, jlan@engr.sgi.com
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
Message-Id: <20050211005446.081aa075.akpm@osdl.org>
In-Reply-To: <1108109504.30559.43.camel@frecb000711.frec.bull.fr>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
	<20050207154623.33333cda.akpm@osdl.org>
	<1108109504.30559.43.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> On Mon, 2005-02-07 at 15:46 -0800, Andrew Morton wrote:
> > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > >
> > > Hello,
> > > 	
> > >    This module sends a signal to one or several processes (in user
> > > space) when a fork occurs in the kernel. It relays information about
> > > forks (parent and child pid) to a user space application.
> > >
> > So this permits ELSA to maintain a complete picture of the process/thread
> > hierarchy?  I guess that fits into the "do it in userspace" mantra -
> > certainly hooking into fork() is a minimal way of doing this, although I
> > wonder what the limitations are.
> > 
> > Implementation-wise: there's a lot of code there and the interface is a bit
> > awkward.  Why not just feed that kobject you have there into
> > kobject_uevent()?
> 
>   Like Andrew suggested, I wrote a new patch (tested on 2.6.11-rc3-mm2)
> that notifies to user space application the creation of a new process
> when kernel forks by using the kobject_uevent() routine.

A bit smaller than the old one ;)

> This funtion
> sends a new event (KOBJ_FORK) through the netlink interface. This new
> event needs an environment (parent pid and child pid) so I used
> send_uevent() like it is done in kobject_hotplug(). 
> 
>   I tested this patch on a 2.6.11-rc3-mm2 kernel and there is a little
> overhead when I compile a Linux kernel:
> 
>    #time sh -c 'make O=/home/guill/build/k2610 bzImage && 
>    make O=/home/guill/build/k2610 modules'
> 
>    with a vanilla kernel: real    8m10.797s
> 	                  user    7m29.652s
> 			  sys     0m49.275s
>    
>    with the forkuevent patch : real    8m16.189s
>                     	       user    7m28.841s
> 		    	       sys     0m49.155s

Was that when some process was monitoring the netlink socket?

We do need to find some way of avoiding all that setup work, just to drop
the constructed message on the floor because nobody was listening for it.

You could just do what send_uevent() does:

kobject_fork()
{
	if (!uevent_sock)
		return;

	...
}

but we should expect that there will be something on the other end of the
uevent socket all the time.

Is there some simple way in which we can record whether there is actually
someone who will be interested in these messages?  I can't immediately
think of one - if we rely on userspace to send on/off messages, then buggy
userspace will leave us in the wrong state.

Still, that's not a catastrophe.  Perhaps invent some simple on/off
messaging on the netlink receive side?  Or use a separate socket, perhaps,
if there's some quick way of working out if any process if prepared to
receive from it.


>  I paste the diff at the end of the mail with wrap line disabled. is it
> better to wrap the patch to 80 characters or is it ok like this?

The patch came through OK.  Wordwrapping it would be doubleplusungood.

> +/* kobject used to notify user space application when a fork occurs */
> +struct kobject fork_kobj;
> +			

fork_kobj can have static scope.

> + */
> +void kobject_fork(struct kobject *kobj, pid_t parent, pid_t child)
> +{
> +	char *kobj_path = NULL;
> +	char *action_string = NULL;
> +	char **envp = NULL;
> +	char ppid_string[FORK_BUFFER_SIZE];
> +	char cpid_string[FORK_BUFFER_SIZE];
> +
> +	action_string = action_to_string(KOBJ_FORK);
> +	if (!action_string)
> +		return;
> +	
> +	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
> +	if (!kobj_path)
> +		return;
> +
> +	envp = kmalloc(FORK_BUFFER_NB * sizeof (char *), GFP_KERNEL);
> +	if (!envp) {
> +		kfree(kobj_path);
> +		return;
> +	}
> +	memset (envp, 0x0, FORK_BUFFER_NB * sizeof (char *));
> +
> +	snprintf(ppid_string, FORK_BUFFER_SIZE, "%i", parent);
> +	snprintf(cpid_string, FORK_BUFFER_SIZE, "%i", child);
> +	
> +	envp[0] = "Not used";
> +	envp[1] = "Not used";
> +	envp[2] = ppid_string;
> +	envp[3] = cpid_string;
> +	envp[4] = NULL;
> +	
> +	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);
> +
> +	kfree(envp);
> +	kfree(kobj_path);
> +	return;
> +}
> +EXPORT_SYMBOL(kobject_fork);

hmm, I have a feeling that the above code is getting duplicated all over
the place.  If there's some consolidation opportunity, that would be a nice
separate patch.

You should move your code inside the #ifdef CONFIG_KOBJECT_UEVENT section,
because it'll just waste space otherwise.  Then make sure that the
appropriate stubs are in place in kobject.h so that the kernel still
compiles if !CONFIG_KOBJECT_UEVENT.

(It seems strange to use a "kobject" here.  What's objective about a
fork()?  I guess it'll do though).

