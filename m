Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWDTMpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWDTMpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDTMpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:45:54 -0400
Received: from tresys.irides.com ([216.250.243.126]:15757 "EHLO
	exchange.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1750713AbWDTMpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:45:53 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Karl MacMillan <kmacmillan@tresys.com>
To: Crispin Cowan <crispin@novell.com>
Cc: Yuichi Nakamura <ynakam@gwu.edu>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kurt Garloff <garloff@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <4446A74F.5010100@novell.com>
References: <20060417225525.GA17463@infradead.org>
	 <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
	 <20060418115819.GB8591@infradead.org>
	 <20060418213833.GC5741@tpkurt.garloff.de>
	 <20060419121034.GE20481@sergelap.austin.ibm.com>
	 <e133c9da8fcba.8fcbae133c9da@gwu.edu>  <4446A74F.5010100@novell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Apr 2006 08:44:18 -0400
Message-Id: <1145537058.28338.34.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 14:10 -0700, Crispin Cowan wrote:

<snip>

> A more problematic case in classic SELinux is personal public_html
> directories
> http://fedora.redhat.com/docs/selinux-apache-fc3/sn-simple-setup.html
> 
> The goal is to allow Apache to access everyone's public_html directory,
> but not the rest of their homedir files. The problem is that each file
> can only have a *single* label on it, and so what label to put on
> public_html directories and their contents?
> 
>     * If you choose user_homedir_t then either
>           o Apache cannot access public_html directories at all, or
>           o Apache gets access to all user homedir contents, including
>             potentially nasty secrets. Not so nice to have your personal
>             secrets leaked out through the web server.
>     * If you choose httpd_sys_content_t then either
>           o Users cannot access their own public_html directories, which
>             is useless, or
>           o Users can write to the system web pages, which means any
>             user can change the system home page.
> 

You seem to be freely switching between describing the targeted and
strict policies here (the link is describing targeted and your example
implies strict), ending up with a description that is not accurate for
either. On a targeted FC5 system httpd_sys_content_t works for users web
pages and SELinux makes no attempt to limit the editing of the files by
the users because they are unconfined. Users are, of course, still
subject to DAC permissions.

With a strict policy it is a simple matter to label user web pages with
httpd_user_content_t (see below) and system web pages with
httpd_sys_content_t and have SELinux determine which users can edit the
system web pages by role. I don't see how the same could be accomplished
with App Armor, so it is strange that you are trying to portray this as
a weakness in SELinux.

> None of the above alternatives are pretty. To solve this problem in a
> labeled system, you would have to have some way of attaching more than
> one label to a single file. You can fake that by creating a software MUX
> that encodes multiple labels into a single label, but that creates an
> explosion in the number of labels. You have to have a new MUX for every
> system daemon that needs to access homedir contents. There is also the
> problem that the public_html directory might be removed and re-created
> by the user, resulting in it automatically inheriting the user_homedir_t
> label.
> 
> This page http://fedora.redhat.com/docs/selinux-faq-fc5/#id2978458
> solves the problem by labeling public_html with httpd_user_content_t.
> This eliminates the need for a MUX by applying the same label to all
> user public_html directories. But it is unclear which applications can
> author httpd_user_content_t content -- and i'm not sure if users are
> allowed to relabel their files.
> 
> Or you can use an AppArmor rule of "/home/*/public_html/** r".
> 

I'm not certain where you came up with this straw man, but arguing that
SELinux is hard because things don't work when you label user's public
html files with types not intended for that purpose is somewhat
surprising.

Following the directions in the faq entry you link to on a FC5 system
works perfectly well for me. Not certain why you are confused about
whether users are allowed to do this relabeling since the faq explicitly
shows how to do this and includes an example session where it
successfully works. As for which applications can edit that type a) most
user applications are unconfined so they will work and b) the question
is easy to answer with any policy analysis tool like Apol or examining
the policy manually.

I would also note that no policy development was needed to enable user
web pages, which I think much easier regardless of how simple the policy
language 

If you want to know why SELinux does not support multiple contexts per
object (by design) there is a long discussion start at
http://www.nsa.gov/selinux/list-archive/0501/thread_body50.cfm.

Karl

> Crispin
