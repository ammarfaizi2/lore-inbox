Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWAWA4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWAWA4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWAWA4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:56:32 -0500
Received: from smtpout.mac.com ([17.250.248.72]:47090 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964793AbWAWA4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:56:31 -0500
In-Reply-To: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
References: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: anon unions are cool
Date: Sun, 22 Jan 2006 19:56:26 -0500
To: Albert Cahalan <acahalan@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2006, at 19:36, Albert Cahalan wrote:
> For example, suppose we wanted to rename a badly-named struct  
> member. If the struct is used all over the kernel, this becomes a  
> giant project with huge potential for patch conflicts.

Actually, pure struct-member renames are not that common, however it  
_is_ common to add an accessor method due to upcoming locking/ 
virtualization changes or similar.  For that case (Using a random  
recent example from the list.  This was decided to not be the best  
route for pid virtualization, but it's just an example):

struct task_struct {
	[...]
	
	pid_t pid;
	
	[...]
};

This would become:

struct task_struct {
	[...]
	
	union {
		pid_t pid __deprecated;
		pid_t __internal_pid;
	};
	
	[...]
};

static inline pid_t task_pid(struct task_struct *t) {
	return t->__internal_pid;
}

Code that used task->pid would get a deprecation warning, however new  
code that used the task_pid(task) would work fine; and the task_pid()  
function itself would generate no warnings.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


