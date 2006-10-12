Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWJLU3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJLU3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWJLU3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:29:30 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:19922 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750820AbWJLU33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:29:29 -0400
Date: Thu, 12 Oct 2006 15:29:26 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Serge Aleynikov <serge@hq.idt.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
Subject: Re: non-critical security bug fix
Message-ID: <20061012202926.GA5690@sergelap.austin.ibm.com>
References: <452D3ED9.509@hq.idt.net> <20061012190647.GA6725@sergelap.austin.ibm.com> <452E96C5.8070307@hq.idt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E96C5.8070307@hq.idt.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Aleynikov (serge@hq.idt.net):
> Serge (what a nice name!  ;-) ),
> 
> Let me give you an example where we found this patch very useful.
> 
> A 3rd party library that we bought implemented a user-level SCTP 
> protocol by opening raw sockets.  This required our application to run 
> as root.  However, we didn't want for it to run as root, and wanted to 
> set the CAP_NET_RAW option and have the interaction with the raw socket 
> survive after when we switch the effective user away from root.
> 
> When reading "man capabilities" we found:
> 
> "If  a  process  that has a 0 value for one or more of its user IDs 
> wants to prevent its permitted capability set being cleared when it 

Right, *permitted*.

> resets all of its user IDs to non-zero values, it can  do  so  using 
> the  prctl() PR_SET_KEEPCAPS operation."
> 
> Correct me if I am wrong, but I believe that this sentence says just 
> what I described above.

No, you're asking for the effective set to also not be cleared, but the
manpage only says the permitted set is maintained.

> If so, the previously attached patch has the 
> behavior described in the man page.

Are you able to modify the source of the application you bought?  If so,
you can trivially fix it to do what you need by doing a cap_set_proc
after the suid as I described before, i.e.

	ret = setuid();
	caps = cap_from_text("cap_net_raw=e");
	ret = cap_set_proc(caps);

Is that an option?

-serge
