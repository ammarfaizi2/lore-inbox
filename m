Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSLUB1o>; Fri, 20 Dec 2002 20:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSLUB1o>; Fri, 20 Dec 2002 20:27:44 -0500
Received: from holomorphy.com ([66.224.33.161]:36808 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261416AbSLUB1h>;
	Fri, 20 Dec 2002 20:27:37 -0500
Date: Fri, 20 Dec 2002 17:35:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021221013500.GN25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <20021221002940.GM25000@holomorphy.com> <190380000.1040432350@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190380000.1040432350@aslan.btc.adaptec.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was removed:
>> Could you split up the new revisions into a series of reviewable
>> patches with clearly-defined individual scope and descriptive changelog
>> entries and post them (in your mail message, not as URL's) please? I
>> actually use this driver at home, so I'd like to be able to understand
>> what's going on with it. I suspect various others are of like mind.

On Fri, Dec 20, 2002 at 05:59:10PM -0700, Justin T. Gibbs wrote:
> You can review all of that information by browsing the BK depot at:
> http://linux-scsi.bkbits.net:8080/scsi-aic7xxx-2.5
> Since the drivers in 2.4 and 2.5 are almost identical, the changelogs
> there apply for 2.4.X too.

This is not in a remotely digestible form.
(1) the entire universe's changesets are mixed together
(2) PITA, I filter for "gibbs", I see a changelog entry that says this:
   Changeset details for 1.865.1.4

   ChangeSet@1.865.1.4  2002-12-12 13:45:46-07:00  gibbs@adaptec.com
   all diffs
   o Kill host template files.
   o Move readme files into the Documentation SCSI directory
   o Enable highmem_io
   o Split out Kconfig files for aic7xxx and aic79xx
   Host template and large disk changes provided or inspired by:
           Christoph Hellwig <hch@sgi.com>

This is one cset??? These are -very- unrelated changes.

So I narrow it down to one file inside there:

   Changes for drivers/scsi/aic7xxx/aic7xxx_osm.c@1.5

   Age Author Annotate Comments
   9 days gibbs@adaptec.com 1.5
   Eliminate separate Linux host template files and move
   all host template entry ponts to one section of the Linux
   osm.c file.
   Add support for larger disks under 2.5.X.
   Enable highmem_io.

So now I have to figure out what you mean by "enable highmem io"
which is a one-line change in the middle of vast amounts of code
being shoveled from one file into another.

Moving around back and forth:

   11 days gibbs 1.865.1.2
   Complete aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2 update.

... another nondescript logentry.

   11 days gibbs 1.858.1.2
   Update to aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2

... and another

   8 days gibbs 1.865.1.5
   Complete the upgrade to aic7xxx 6.2.23 and aic79xx 1.3.0_ALPHA3.

... and another.

How many URL's do you expect me to chase here? Do I have to find
your *BSD cvs/whatever repo to extract meaningful log entries or are
even the cvs commit messages there useless?

So off to www.freebsd.org and right there is a very different story:

Revision 1.43, Sat Nov 30 19:30:09 2002 UTC (2 weeks, 6 days ago) by scottl
Branch: MAIN
CVS Tags: RELENG_5_0_BP, RELENG_5_0, HEAD
Changes since 1.42: +44 -7 lines

Bring in many bugfixes and changes obtained from formal testing:

        aic7xxx.c:
        aic7xxx.h:
        aic7xxx.reg:
        aic7xxx.seq:
                Bring in the protocol violation handler from the U320
                driver and replace the NO_IDENT sequencer interrupt code
                with the PROTO_VIOLATION code.  Support for this code
                required the following changes:

                SEQ_FLAGS:
                        IDENTIFY_SEEN -> NOT_IDENTIFIED
                        Added NO_CDB_SENT

                SCB_CONTROL:
                        TARGET_SCB == STATUS_RCVD for initiator mode

                scb->flags:
                        Added SCB_TARGET_SCB since we cannot rely on
                        TARGET_SCB as a target/initiator differentiator
                        due to it being overloaded in initiator mode to
                        indicate that status has been received.
        aic7xxx.seq:
                Move data fifo CLRCHN to mesgin_rdptrs which is a safer
                location for doing this operation.  This also saves a
                sequencer instruction.

        aic7xxx.c:
        aic7xxx.h:
                Change ahc/ahd_upate_neg_request() to take a "negotiation
                type" enum that allows us to negotiate:
                        o only if the goal and current parameters differ.
                        o only if the goal is non-async
                        o always - even if the negotiation will be for async.
        aic7xxx.seq:
                Reset the FIFO whenever a short CDB transfer occurs
                so that the FIFO contents do not corrupt a future CDB
                transfer retry.

                Add support for catching the various protocol violations
                handled by ahc_handle_protocol_violation.

                Reformat some comments.

        aic7xxx.c:
        aic7xxx.h:
                Just for safety, have the aic7xxx driver probe
                the stack depth.

        aic7xxx.c:
        aic7xxx.h:
                Save and restore stack contents during diagnostics.
                Some chip variants overwrite stale entries on a
                stack "pop".

                Don't use 0 to probe the stack depth.  0 is the typical
                value used to backfill the stack if entries are overwritten
                on a "pop".
        aic7xxx.h:
                Add a missing typedef.

                Collapse SCB flag entries so they are bit contiguous.

                Add AHD_ULTRA2_XFER_PERIOD for narrow fallback calculations

        aic7xxx.c:
                Don't panic (as a diagnostic to catch bugs) if we decided to
                force the renegotiation of async even if we believe we are
                already async.  This should allow us to negotiate async instead
                of the full user goal rate during startup if bus resets are
                disabled.

                Add a space to the end of the ahc/ahd_print_devinfo routines
                so that it behaves as expected by the code that uses it.

                Only force a renegotiation on a selection timeout
                if the SCB was valid.  Doing otherwise may be dangerous
                as the connection was not valid for an unknown reason.

                Add additional diagnostic output to ahc_dump_card_state(),
                and have it use the register pretty printing functions.

                Update ahc_reg_print() to handle a NULL cur_col.

                Add a newline to ahc_dump_card_state() output.

                Bring back "use_ppr".  We need to use_ppr anytime
                doppr is true or we have non-zero protocol options.
                The later case was not handled in the recent removal
                of use_ppr.

                Move a comment and remove a useless clearing of use_ppr.

                Don't disable ENBUSFREE when single stepping on
                a DT capable controller.  We cannot re-enable unexpected
                busfree detection, so we must clear BUSFREE on each
                step instead.
                Correct the lookup of the SCB ID in ahc_handle_proto_error.

                Remove a diagnostic printf.
                Remove unecessary restoration of the STACK for older
                chips.

Approved by:	re (blanket)

Wow! Now that's what I call descriptive.

The changes listed under gibbs there seem to be mostly p4 ID synchs.
Not sure what to make of those. But I did find this:


Revision 1.19, Sat Aug 31 06:46:37 2002 UTC (3 months, 2 weeks ago) by gibbs
Branch: MAIN
CVS Tags: RELENG_5_0_BP, RELENG_5_0, HEAD
Changes since 1.18: +10 -1 lines

If interrupts are disabled on the card, don't bother running
our interrupt handler.  Our handler was called due to a shared
interrupt, and the card's interrupts are explicitly disabled
to prevent entry into our interrupt handler.

The diff is actually this:

===================================================================
RCS file: /home/ncvs/src/sys/dev/aic7xxx/aic7xxx_inline.h,v
retrieving revision 1.18
retrieving revision 1.19
diff -u -p -r1.18 -r1.19
--- src/sys/dev/aic7xxx/aic7xxx_inline.h	2002/04/24 16:58:51	1.18
+++ src/sys/dev/aic7xxx/aic7xxx_inline.h	2002/08/31 06:46:37	1.19
@@ -37,9 +37,9 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  *
- * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_inline.h#33 $
+ * $Id: //depot/aic7xxx/aic7xxx/aic7xxx_inline.h#38 $
  *
- * $FreeBSD: /home/ncvs/src/sys/dev/aic7xxx/aic7xxx_inline.h,v 1.18 2002/04/24 16:58:51 gibbs Exp $
+ * $FreeBSD: /home/ncvs/src/sys/dev/aic7xxx/aic7xxx_inline.h,v 1.19 2002/08/31 06:46:37 gibbs Exp $
  */
 
 #ifndef _AIC7XXX_INLINE_H_
@@ -494,6 +494,15 @@ ahc_intr(struct ahc_softc *ahc)
 {
 	u_int	intstat;
 
+	if ((ahc->pause & INTEN) == 0) {
+		/*
+		 * Our interrupt is not enabled on the chip
+		 * and may be disabled for re-entrancy reasons,
+		 * so just return.  This is likely just a shared
+		 * interrupt.
+		 */
+		return;
+	}
 	/*
 	 * Instead of directly reading the interrupt status register,
 	 * infer the cause of the interrupt by checking our in-core


This is very much smaller than the individual csets you're pushing
to Linux, and has a changelog entry with actual content. Is there any
chance you could send us changes as modular and well-documented as these?


Thanks,
Bill
