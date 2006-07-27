Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWG0SGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWG0SGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWG0SGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:06:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62692 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751908AbWG0SGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:06:37 -0400
Date: Thu, 27 Jul 2006 20:06:34 +0200
From: Petr Baudis <pasky@suse.cz>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060727180634.GA28962@pasky.or.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Jul 27, 2006 at 04:25:07PM CEST, I got a letter
where Pekka J Enberg <penberg@cs.Helsinki.FI> said that...
> +	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
> +		err = -EPERM;
> +		goto out;
> +	}

Consider:

int main(int argc, char *argv[])
{
	int log = open(argv[1], O_WRONLY | O_APPEND);
	while (1) {
		struct { char *uname, *pwd; } *creds = get_credentials_from_user();
		int shadow = open("/etc/shadow", O_RDWR | O_APPEND);
		fprintf(log, "creds for %s lookup success: %d\n", uname, lookup_in_shadow(shadow, creds));
		do_whatever_strange(shadow);
		close(shadow);
	}
}

Make that setuid root or just create log file owned by you and make root
run it.  Should be innocent enough, right?

Well, except that you can revoke the log file before the shadow file is
opened, at which point open() probably reuses the fd and the program
conveniently logs to /etc/shadow.

You shouldn't let people do this to poor innocent processes running with
different uids.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
