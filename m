Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319203AbSIDQJi>; Wed, 4 Sep 2002 12:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319206AbSIDQJi>; Wed, 4 Sep 2002 12:09:38 -0400
Received: from host194.steeleye.com ([216.33.1.194]:25100 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S319203AbSIDQJh>; Wed, 4 Sep 2002 12:09:37 -0400
Message-Id: <200209041613.g84GDtv02639@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Tue, 03 Sep 2002 18:50:36 EDT." <20020903185036.G12201@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Sep 2002 11:13:54 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dledford@redhat.com said:
> Now, granted, that is more complex than going straight to a BDR, but I
>  have to argue that it *isn't* that complex.  It certainly isn't the
> nightmare you make it sound like ;-) 

It's three times longer even in pseudocode...

However, assume we do this (because we must for barrier preservation).  The 
chances are that for a failing device we're aborting a significant number of 
the tags.  This is quite a big increase in the message load over what we do 
now---Particularly for the AIC driver which can have hundreds of tags 
outstanding (murphys law says it's usually the earilest tag which times out).  
I'm not convinced that a BDR, which is a single message and has roughly the 
same effect, isn't preferable.

However, what about a compromise?  We can count outstanding commands, so what 
about doing abort *if* the number of outstanding commands is exactly one (the 
one we're trying to abort).  This means for devices that don't do TCQ (like 
old CD-ROMs) we'll always try abort first.  For large numbers of outstanding 
tags, we skip over abort and move straight to BDR.  The code to implement this 
will be clean and simple because abort no longer has to pay attention to the 
barrier.

James


