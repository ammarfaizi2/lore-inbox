Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWDTATo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWDTATo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 20:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDTATo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 20:19:44 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:25823 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751156AbWDTATn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 20:19:43 -0400
Message-ID: <4446D378.8050406@novell.com>
Date: Wed, 19 Apr 2006 17:19:04 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>            <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
In-Reply-To: <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 18 Apr 2006 13:13:03 PDT, Crispin Cowan said:
>   
>> This gives the system administrator the ability to force applications to
>> "drop" privs even when the application developer didn't bother, or (as
>> was the case in a Sendmail vulnerability several years ago) the
>> application *tried* to drop privs and got it wrong, so was running as
>> full root anyway.
>>     
> Interestingly enough, the Sendmail bug was a case where it was forced to "drop"
> some privs, and then it didn't have enough privs to drop the rest of the privs.
>
> In other words, it's quite possible to accidentally introduce a vulnerability
> that wasn't exploitable before, by artificially restricting the privs in a way
> the designer didn't expect.  So this is really just handing the sysadmin
> a loaded gun and waiting.
>   
While that is true of the voluntary model of acquiring and dropping
privs, it is not true of AppArmor containment, which will just not give
you the priv if it is not in your policy.

> (Incidentally, both SELinux and presumably AppArmor have the same problem - it
> is really hard to convince yourself that you've identified *all* the access that
> a given program needs.  People keep finding ways to excersize previously untested
> code paths and error handlers, resulting in a game of whack-a-mole as the program
> fails due to a lack of permissions.  This is especially fun to debug when the
> program is already in an error handler... ;)
>   
That is true: both SELinux and AppArmor use a white list within a single
application policy (for the Targeted Policy) leading to this problem.

White lists have the property of being highly secure, but a big pain in
the ass because they *must* be complete, and you shoot yourself in the
foot if they are not. Black lists are the exact dual; relatively
insecure, and relatively easy to use.

AppArmor uses a hybrid white list/black list approach:

    * Per profile, it is white list: when we confine a program, we
      specify every file and POSIX.1e Capability that it can access.
      This includes an inheritance model, so that all of the children
      that it forks are also confined by policy; what they can exec() is
      controlled.
    * System-wide it is black-list: only programs with an explicit
      policy are confined. However, because of the inheritance model,
      confined programs cannot escape by just exec()'ing some program
      that is not normally confined: AppArmor controls what you can
      exec, and thus controls what other policies you can transition to.

AppArmor also aggressively uses wildcards in policy generation, so you
can e.g. grant "/etc/apache2/** r" and "/srv/www/htdocs/** r" to Apache,
and then not have to care whether you fully exercised all of Apache's
configurations and hit all of the web pages.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

