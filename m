Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992745AbWJUALg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992745AbWJUALg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992747AbWJUALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:11:35 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:63325 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S2992745AbWJUALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:11:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LTfx22wuNmTEqt8FW9Wcj1elWZaTzaHHnLfRFFIy5NAvJ4N0Bpqt9YWvUoaYDj+ALy3/FclPqyZFqNy2P/662fFOxij2GNxSWij8YZ1tDsZpJe1PTvJvcqhfbl1fkTh5WkH9q1feiJvIhE6Kr3GMngOqa8OYd+VYSZMqCuz4G9Q=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 04/10] uml: make execvp safe for our usage
Date: Sat, 21 Oct 2006 02:11:28 +0200
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212711.26445.79770.stgit@americanbeauty.home.lan> <20061018183707.GB6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183707.GB6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610210211.28502.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 20:37, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:11PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Reimplement execvp for our purposes - after we call fork() it is
> > fundamentally unsafe to use the kernel allocator - current is not valid
> > there.
>
> This is horriby ugly.

Detail why. The code of execvp()? Passing in the buffer?
I'm not saying it's the brightest code around here, but it's ok for me.

> Can we instead do something different like 
> check out the paths of helpers at early boot, before the kernel is
> running, save them, and simply execve them later?
I initially thought to design a two-steps API with a "which" operation (where 
memory allocation was used) to call later execvp(); when I saw the glibc 
implementation (it allocates one single fixed-size buffer) I saw it was 
simpler this way.

Additionally, error handling cannot be done properly without trying an exec - 
I think it is also ok to drop this execvp semantic, so that if the first 
binary found in path is marked executable but has the wrong binary format the 
whole thing just does not start.

The current implementation already diverges from glibc - it never calls 
directly the shell passing a script, because IMHO execve() will care for that 
(and testing confirmed this IIRC).

I'd not do that at boot, but just before the fork()+execve() - it is 
conceivable that a given user will install a support binary after booting 
UML.

I must say that I've seen files without the shebang working ok (if having the 
executable bit set) when executed from the shell, and I've had the doubt 
execvp() would handle that.

> At that point, something like running "which foo" would be fine by me.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
