Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291335AbSBGVh1>; Thu, 7 Feb 2002 16:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291331AbSBGVhH>; Thu, 7 Feb 2002 16:37:07 -0500
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:18188 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S291329AbSBGVhE>;
	Thu, 7 Feb 2002 16:37:04 -0500
Date: Thu, 7 Feb 2002 15:38:13 -0600 (CST)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
In-Reply-To: <20020206191108.A11277@suse.de>
Message-ID: <20020207152233.D6457-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Dave Jones wrote:

> On Tue, Feb 05, 2002 at 09:52:55PM -0600, Brent Cook wrote:
>
>  >  I think that I have found a problem with proc_dir_entry(). It seems to
>  > allow multiple /proc entries to be created with the same name, without
>  > returning a NULL pointer. I asked the folks on #kernelnewbies, and they
>  > said that perhaps this is a feature. In either case, I believe that the
>  > following patch fixes the issue by checking if a proc entry already exists
>  > before creating it. This mirrors the behavior of remove_proc_entry, which
>  > checks for the presense of a proc entry before deleting it.
>
>  The only instance I've seen of this happen is the acpi code.
>  Whilst the patch is good in the sense that it allows things like
>  /proc/acpi/button to become usable, the correct fix would be
>  to fix ACPI.
>
>  Maybe printk'ing a "tried to create duplicate xxx proc entry"
>  would be useful, so we at least don't paper over problems and
>  make them harder to find later.
>

I had problems with loading kernel modules more in mind with this patch.
Try loading a kernel module that creates a /proc entry and then loading it
again with a different name. If the original module that created the /proc
entry is then unloaded, any further attempts to read the remaining proc
entry leads to a NULL pointer being handed back to the reading process.

I'm not sure about the printk's for that specific error condition, when
proc_dir_entry() already simply returns a NULL pointer on the two other
failure conditions that it checks. At the minimum, proc_dir_entry() should
hand back a NULL pointer on duplication. Then the calling module or kernel
code can look at the return value of proc_dir_entry() to determine if it
was successfull. The downside of just this is that you don't know why an
error occurred, just that one did.

It seems that this return value is handled differently (if at all ;)
throughout the kernel, so I don't know what effects having another error
condition might have on other code, such as acpi.

 - Brent

