Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424164AbWKIRjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424164AbWKIRjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966048AbWKIRjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:39:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:29101 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966047AbWKIRjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:39:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=aeUAdviV7xWtysSIMYL4soRQlEcQQikKn/DSFVXMb0jo89jrQqPfRHHr+mDu0XjLVMuCG2P7cMpSGzdebhmLSD4CqvKZFWyThhde9ZQJUkyjB/+cyJxrQ23gGBjaP35Eim2CZbCDexiZ1livIW/NGoAuPaR1IwCcfrRWMUJP/2U=
Message-ID: <eb97335b0611090939x7afbca7fkb5da56a15f0895c0@mail.gmail.com>
Date: Thu, 9 Nov 2006 09:39:13 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Sergey Vlasov" <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <1163090431.12241.358.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	 <20061108102037.GA6602@sequoia.sous-sol.org>
	 <20061108154229.eb6d4626.vsu@altlinux.ru>
	 <20061109041400.GB6602@sequoia.sous-sol.org>
	 <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
	 <eb97335b0611090808q4738d29ai88da69aab97a84aa@mail.gmail.com>
	 <1163090431.12241.358.camel@moss-spartans.epoch.ncsc.mil>
X-Google-Sender-Auth: 259035443ec003d8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Unless I missed something, your plan above would disable SELinux
> syslog-related permission checking upon reads of a previously opened
> file descriptor to /proc/kmsg.  So it would change SELinux behavior in a
> way that is directly contrary to the notion of mandatory access control.

Yes, it would do that; no, I don't see why that change is contrary to
the notion of mandatory access control.  An open fd on /proc/kmsg
(with my changes applied) offers strictly fewer privileges than
SYSTEM__SYSLOG_MOD (no access to opcodes 4 and 5), and with SELinux
active, you can't get that open fd without having had
SYSTEM__SYSLOG_MOD at some prior time.  SELinux does not (as far as I
can tell) do MAC checks for access to normal files at read() time,
only open().

I see this as bringing /proc/kmsg in line with standard Unix file
permission semantics, overall.

> Part 4 appears to further expose /proc/kmsg to access by any uid 0
> process even if it has no capabilities (think privilege shedding or
> containers).

Only in the default privilege model, not in SELinux.  (CAP_SYS_ADMIN
is a hell of a lot more powerful than SYSTEM__SYSLOG_MOD.)  And I
could be talked out of part 4.

> But having a mapping in the core to a much
> smaller set of permissions would be even better, and help with
> maintenance; the next time someone added a new code, they would more
> likely see the mapping table in the core and update it than go digging
> into the individual security modules.

But that mapping is itself a security policy decision, and could
plausibly need to be done differently in different security modules...

zw
