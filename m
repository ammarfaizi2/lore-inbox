Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262376AbSI2DCq>; Sat, 28 Sep 2002 23:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262377AbSI2DCq>; Sat, 28 Sep 2002 23:02:46 -0400
Received: from ns.suse.de ([213.95.15.193]:57094 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262376AbSI2DCp>;
	Sat, 28 Sep 2002 23:02:45 -0400
Date: Sun, 29 Sep 2002 05:08:07 +0200
From: Andi Kleen <ak@suse.de>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929050807.A17869@wotan.suse.de>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929025224.GA68153@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Basically it's a matter of :
> 
> 	task_struct *
> 	EIP/Event
> 	EIP/Event
> 	EIP/Event
> 	EIP/Event
> 	....

I think you can easily do that by keeping state per cpu in the 
NMI handler.

	if (current == __get_cpu_var(oprofile_cpustate)) { 
		/* log current */
		__get_cpu_var(oprofile_cpustate) = current; 	
	} else { 
		/* do nothing */ 
	}
	/* log EIP */

[or when you are an module use an cache line padded array indexed with
smp_processor_id - per cpu data doesn't work from modules]

This is even more efficient because when the NMI rate is lower than
the task switch frequency (which is not unlikely) then you'll avoid
many useless task_struct loggings.

-Andi
	
