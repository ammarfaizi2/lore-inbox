Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbRE0TlE>; Sun, 27 May 2001 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRE0Tky>; Sun, 27 May 2001 15:40:54 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:31041
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262021AbRE0Tkk>; Sun, 27 May 2001 15:40:40 -0400
Date: Sun, 27 May 2001 21:40:33 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for buggy variable reuse in riotable.c (244ac18)
Message-ID: <20010527214033.J857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot l-k when sending this off...

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch fixes a buggy variable reuse i drivers/char/
rio/riotable.c (244-ac18) as reported by the stanford team way
back.


--- linux-244-ac18-clean/drivers/char/rio/riotable.c	Sun May 27 20:19:56 2001
+++ linux-244-ac18/drivers/char/rio/riotable.c	Sun May 27 21:12:16 2001
@@ -501,7 +501,7 @@
 	struct Map *HostMapP;
 	struct Port *PortP;
 	int work_done = 0;
-	unsigned long flags;
+	unsigned long lock_flags, sem_flags;
 
 	rio_dprintk (RIO_DEBUG_TABLE, "Delete entry on host %x, rta %x\n",
 								MapP->HostUniqueNum, MapP->RtaUniqueNum);
@@ -509,10 +509,10 @@
 	for ( host=0; host < p->RIONumHosts; host++ ) {
 		HostP = &p->RIOHosts[host];
 
-		rio_spin_lock_irqsave( &HostP->HostLock, flags );
+		rio_spin_lock_irqsave( &HostP->HostLock, lock_flags );
 
 		if ( (HostP->Flags & RUN_STATE) != RC_RUNNING ) {
-			rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
+			rio_spin_unlock_irqrestore(&HostP->HostLock, lock_flags);
 			continue;
 		}
 
@@ -529,7 +529,7 @@
 					if ( HostMapP->Topology[link].Unit != ROUTE_DISCONNECT ) {
 						rio_dprintk (RIO_DEBUG_TABLE, "Entry is in use and cannot be deleted!\n");
 						p->RIOError.Error = UNIT_IS_IN_USE;
-						rio_spin_unlock_irqrestore( &HostP->HostLock, flags);
+						rio_spin_unlock_irqrestore( &HostP->HostLock, lock_flags);
 						return EBUSY;
 					}
 				}
@@ -544,7 +544,7 @@
 						PortP = p->RIOPortp[port];
 						rio_dprintk (RIO_DEBUG_TABLE, "Unmap port\n");
 
-						rio_spin_lock_irqsave( &PortP->portSem, flags );
+						rio_spin_lock_irqsave( &PortP->portSem, sem_flags );
 
 						PortP->Mapped = 0;
 
@@ -602,7 +602,7 @@
 							WWORD(PortP->PhbP->destination,
 							 dest_unit + (dest_port << 8));
 						}
-						rio_spin_unlock_irqrestore(&PortP->portSem, flags);
+						rio_spin_unlock_irqrestore(&PortP->portSem, sem_flags);
 					}
 				}
 				rio_dprintk (RIO_DEBUG_TABLE, "Entry nulled.\n");
@@ -610,7 +610,7 @@
 				work_done++;
 			}
 		}
-		rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
+		rio_spin_unlock_irqrestore(&HostP->HostLock, lock_flags);
 	}
 
 	/* XXXXX lock me up */
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

We're going to turn this team around 360 degrees.
-Jason Kidd, upon his drafting to the Dallas Mavericks

----- End forwarded message -----
