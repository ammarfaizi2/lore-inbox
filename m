Return-Path: <linux-kernel-owner+w=401wt.eu-S932572AbXAAXxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbXAAXxi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAAXxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:53:38 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:33138 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbXAAXxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:53:37 -0500
Date: Mon, 1 Jan 2007 18:53:28 -0500
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20070101235320.GS8104@delft.aura.cs.cmu.edu>
Mail-Followup-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Pavel Machek <pavel@suse.cz>,
	Arjan van de Ven <arjan@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <20061229100223.GF3955@ucw.cz> <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 11:47:06PM +0100, Mikulas Patocka wrote:
> >Anyway, cp -a is not the only application that wants to do hardlink
> >detection.
> 
> I tested programs for ino_t collision (I intentionally injected it) and 
> found that CP from coreutils 6.7 fails to copy directories but displays 
> error messages (coreutils 5 work fine). MC and ARJ skip directories with 
> colliding ino_t and pretend that operation completed successfuly. FTS 
> library fails to walk directories returning FTS_DC error. Diffutils, find, 
> grep fail to search directories with coliding inode numbers. Tar seems 
> tolerant except incremental backup (which I didn't try). All programs 
> except diff were tolerant to coliding ino_t on files.

Thanks for testing so many programs, but... did the files/symlinks with
colliding inode number have i_nlink > 1? Or did you also have directories
with colliding inode numbers. It looks like you've introduced hardlinked
directories in your test which are definitely not supported, in fact it
will probably cause not only issues for userspace programs, but also
locking and garbage collection issues in the kernel's dcache.

I'm surprised you're seeing so many problems. The only find problem that
I am aware of is the one where it assumes that there will be only
i_nlink-2 subdirectories in a given directory, this optimization can be
disabled with -noleaf. The only problems I've encountered with ino_t
collisions are archivers and other programs that recursively try to copy
a tree while preserving hardlinks. And in all cases these seem to have
no problem with such collisions as long as i_nlink == 1.

Jan
