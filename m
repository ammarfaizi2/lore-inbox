Return-Path: <linux-kernel-owner+w=401wt.eu-S965019AbWLTNVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWLTNVc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWLTNVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:21:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:17113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965020AbWLTNVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:21:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender;
        b=CYTsRRkBcYA4V4C9L02ZHzudMBxa08aRSZ1PTxlWqmtYGxjN2j0L4/YhZqb1Jcz4s6UWTdjh7eEeQ6/1P2vTYjfzKY14JE89UDKbQkXTONeazs2ZnZeFKB5N9ngUn20sFnewExZK6tvBQ7wtwR/pXkSYGXbqBVOhTfaZZnrf35M=
From: David Wragg <david@wragg.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: david@wragg.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
Date: Wed, 20 Dec 2006 13:20:08 +0000
In-Reply-To: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	(Albert Cahalan's message of "Wed\, 20 Dec 2006 00\:40\:57 -0500")
Message-ID: <878xh2aelz.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:
> On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
>> This patch (against 2.6.19/2.6.19.1) adds the four context
>> switch values (voluntary context switches, involuntary
>> context switches, and the same values accumulated from
>> terminated child processes) to the end of /proc/*/stat,
>> similarly to min_flt, maj_flt and the time used values.
>
> Hmmm, OK, do people have a use for these values?

My reason for writing the patch was to track which processes are
active (i.e. got scheduled to run) by polling these context switch
values.  The time used values are not a reliable way to detect process
activity on fast machines.  So for example, when sorting by %CPU, top
often shows many processes using 0% CPU, despite the fact that these
processes are running occasionally.  If top sorted by (%CPU, context
switch count delta), it might give a more useful display of which
processes are active on the system.

More generally, it seems perverse to track these context switch values
but only expose them through the constrained getrusage interface.  If
they are worth having, why aren't they worth exposing in the same way
as all other process info?

> [...]
>> Putting just these four values into a new file would seem a little
>> odd, since they have a lot in common with the other getrusage values
>> that are already in /proc/pid/stat.  One possibility is to add
>> /proc/pid/rusage, mirroring the full struct rusage in text form, since
>> struct rusage is already part of the kernel ABI (though Linux doesn't
>> fill in half of the values).
>
> Since we already have a struct defined and all...
>
> sys_get_rusage(int pid)

That would be a much more useful system call than getrusage.  But why
have two ways of retrieving process info, /proc and a sys_get_rusage,
exposing differing subsets of process information?


David
