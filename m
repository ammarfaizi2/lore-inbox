Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTIWMtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTIWMtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:49:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8890
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263358AbTIWMt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:49:28 -0400
Date: Tue, 23 Sep 2003 14:49:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923124951.GB23111@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923042855.GF589@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 06:28:55AM +0200, Willy Tarreau wrote:
> Hi,
> 
> (it was from me)
>  
> On Mon, Sep 22, 2003 at 09:48:33PM +0200, Andrea Arcangeli wrote:
> > Hi,
> > 
> > I'm rejecting on the log-buf-len feature in 2.4.23pre5, the code in
> > mainline is worthless for any distributor, shipping another rpm package
> > just for the bufsize would be way overkill.
> > 
> > Please backout the below (extracted from bkcvs) and apply this one
> > instead:
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22aa1/00_log-buf-len-1
> 
> Well, Andrea, I've looked at your patch. I really like the dynamic size
> reconfiguration, but:
>   - now it becomes mandatory to add a command line option, just for this. It's
>     annoying when you want to build install images for many systems. I've
>     always considered that command line parameters should be limited to the
>     strict minimum to have a system boot reliably (root=, console=, very few
>     IDE/SCSI/ACPI tuning when absolutely needed) and that's all.
>   - what does the initial __log_buf[] become after log_buf_len_setup() ? can
>     these 64 kB be freed or are they definitely lost ?
> 
> I think that perhaps we should merge the two things, but reconfigure them
> differently :
> 
>   - be able to specify de DEFAULT buffer size at compile time.
>   - have it reconfigurable at run time with a sysctl (this could be something
>     next to 'prink', or even a write to kmsg). This way, if you detect that
>     your system is still loosing messages under load, you have a chance to
>     catch them all.
>   - initialize the buffer with allocated memory from the beginning so that we
>     can free it when changing the buffer size. 
> 
> I can spend a few hours working with you on this if you're interested. But be
> assured that I know enough people who would complain about being forced to
> add a new boot option to their lilo.conf.

The point here is that the default must work for 99% of the userbase.
Either that or the default is totally broken.

So the rest of 1% should be ok to add the command line, and they should
be very happy that when they overflow again even with 128k because their
cpu is too slow to keep up in klogd or whatever, they can change it to
256k without replacing kernels, some embedded platforms especially
should like it. And only this 1% would be the one recompiling the kernel
by themself anyways, and if they can recompile the kernel they can as
well edit the defaults in kernel/printk.c without pain.

I don't buy much the lazyness argument in changing lilo.conf, the people
who need this feature is a marginal part so they must be ok with the
parmeter. And don't tell me that you don't pass root= to the kernel at
boot. Do you want to fix that too? I do pass plenty of argumetns all the
time, starting from profile=0 (and often acpi=off).

however I won't complain if you put the compile time configurator on top
of my patch (that's easy) but personaly I think it's not needed, and
having it dyanmic is an order of magnitude more important than having it
static (again: if you can afford to recompile the kernel than you could
edit kernel/printk.c in the first place without much slowdown).

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
