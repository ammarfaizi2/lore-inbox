Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269729AbUJMO3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269729AbUJMO3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJMO3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:29:00 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:23797 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S269726AbUJMO2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:28:53 -0400
Subject: Re: [patch 2/3] lsm: add bsdjail module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <416C5C26.9020403@redhat.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	 <1097094270.6939.9.camel@serge.austin.ibm.com>
	 <20041006162620.4c378320.akpm@osdl.org>
	 <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20041010104113.GC28456@infradead.org>
	 <1097502444.31259.19.camel@localhost.localdomain>
	 <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <416C5C26.9020403@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1097677501.32468.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 10:25:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 18:35, Ulrich Drepper wrote:
> Serge E. Hallyn wrote:
> 
> > +If a private IP was specified for the jail, then
> > +		cat /proc/$$/attr/current
> 
> How is this going to interact with SELinux?  Currently SELinux uses
> /proc/*/attr/current to report the current security context of the
> process.  libselinux expects the file to contain one string (not even a
> newline) which is the textual representation of the context.  Now with
> your changes you want to change this.  libselinux as-is would break
> miserably.

libselinux is_selinux_enabled() checks /proc/filesystems for selinuxfs
first, and SELinux userland checks is_selinux_enabled().  As security
modules cannot presently be stacked if they both use the security
fields, this is sufficient.  There were patches floated on
rhselinux-list circa Oct 2003 to add a "selinux/" prefix to the
/proc/pid/attr values to explicitly identify the security module, ala
the "security.selinux" attribute name for the file extended attribute,
but the consensus at that time was that it was sufficient to test for
the presence of SELinux via /proc/filesystems.

> I don't know the history of the file and who is hijacking the file.
> Fact is that the file content is currently unstructured and libselinux
> couldn't possibly determine what part is of interest to itself.

The /proc/pid/attr interface was submitted by us based on Al Viro's
recommendations when the SELinux API was overhauled.  We attempted to
keep it sufficiently general that other security modules could also use
it, but not at the same time, as shared use of LSM security fields
wasn't supported anyway.  We had earlier proposed [gs]etprocattr calls
ala [gs]etxattr calls with distinguished attribute names, but were
directed to use /proc instead.

> So, either you use another file, SELinux uses another file, or the file
> gets tagged lines like
> 
>   selinux: user_u:user_r:user_t

One value per file seems preferred, but /proc/pid doesn't lend itself to
dynamic extension by modules.  [gs]etprocattr calls ala [gs]etxattr
calls would be simpler if we want to export multiple attribute names,
but that was also suggested earlier and rejected.

Side bar:  Any change here also affects upstream procps, which presently
directly takes the /proc/pid/attr/current value and displays it as a
single field.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

