Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWCHW7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWCHW7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWCHW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:59:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030241AbWCHW7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:59:30 -0500
Date: Wed, 8 Mar 2006 17:59:25 -0500
From: Dave Jones <davej@redhat.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on ibmasm
Message-ID: <20060308225924.GB21130@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
	linux-kernel@vger.kernel.org
References: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:41:45AM +1100, Srihari Vijayaraghavan wrote:
 > command count: 1
 > input: ibmasm RSA I remote mouse as
 > /class/input/input2
 > input: ibmasm RSA I remote keyboard as
 > /class/input/input3
 > ibmasm remote responding to events on RSA card 0
 > command count: 2
 > ibmasm_exec_command:130 at 1141819512.780778
 > do_exec_command:107 at 1141819512.780787
 > respond to interrupt at 1141819512.782055
 > exec_next_command:150 at 1141819512.782094
 > finished interrupt at   1141819512.782103
 > command count: 1
 > Unable to handle kernel paging request at virtual
 > address 6b6b6b6b

the problem is we do this..

    command_put(sp->current_command);
	exec_next_command(sp);

command_put drops the refcount of the kobject in sp,
which then gets freed in the .release (free_command)
which ends up kfree'ing 'sp'.

unsurprisingly, it goes bang the next time something
tries to access it.  (Ie the 2nd line above)

It's totally busted.

		Dave

-- 
http://www.codemonkey.org.uk
