Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVCDUWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVCDUWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVCDURa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:17:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263048AbVCDTy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:54:57 -0500
Subject: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-NH6nALFO9biDlEuRc9gQ"
Message-Id: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 04 Mar 2005 19:54:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NH6nALFO9biDlEuRc9gQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

For the past few months there has been a slow but steady trickle of
reports of oopses in kjournald.  Recently I got a couple of reports that
were repeatable enough to rerun with extra debugging code.

It turns out that we're releasing a journal_head while it is still
linked onto the transaction's t_locked_list.  The exact location is in
journal_unmap_buffer().  On several exit paths, that does:

		spin_unlock(&journal->j_list_lock); 
		jbd_unlock_bh_state(bh);
		spin_unlock(&journal->j_state_lock);
		journal_put_journal_head(jh);

releasing the jh *after* dropping the j_list_lock and j_state_lock.

kjournald can then be doing journal_commit_transaction():

	spin_lock(&journal->j_list_lock);
...
		if (buffer_locked(bh)) {
			BUFFER_TRACE(bh, "locked");
			if (!inverted_lock(journal, bh))
				goto write_out_data;
			__journal_unfile_buffer(jh);
			__journal_file_buffer(jh, commit_transaction,
						BJ_Locked);
			jbd_unlock_bh_state(bh);

The problem happens if journal_unmap_buffer()'s own put_journal_head()
manages to get in between kjournald's *unfile_buffer and the following
*file_buffer.  Because journal_unmap_buffer() has dropped its bh_state
lock by this point, there's nothing to prevent this, leading to a
variety of unpleasant situations.  In particular, the jh is unfiled at
this point, so there's nothing to stop the put_journal_head() from
freeing the memory we're just about to link onto the BJ_Locked list.

I _think_ that the attached patch deals with this, but I'm still
awaiting further testing to be sure.  I thought I might as well get some
other ext3 eyes on it while I wait for that -- I'll let you know as soon
as I hear back from the other testing.

The patch works by making sure that the various exits from
journal_unmap_buffer() always call journal_put_journal_head() *before*
unlocking the j_list_lock.  This is correct according to the documented
lock ranking, and it also matches the order in the existing main exit
path at the end of the function.

Cheers,
  Stephen


--=-NH6nALFO9biDlEuRc9gQ
Content-Disposition: inline; filename=ext3-release-race.patch
Content-Type: text/plain; name=ext3-release-race.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi1leHQzL2ZzL2piZC90cmFuc2FjdGlvbi5jLj1LMDAwMD0ub3JpZw0KKysr
IGxpbnV4LTIuNi1leHQzL2ZzL2piZC90cmFuc2FjdGlvbi5jDQpAQCAtMTc3NSwxMCArMTc3NSwx
MCBAQCBzdGF0aWMgaW50IGpvdXJuYWxfdW5tYXBfYnVmZmVyKGpvdXJuYWxfDQogCQkJSkJVRkZF
Ul9UUkFDRShqaCwgImNoZWNrcG9pbnRlZDogYWRkIHRvIEJKX0ZvcmdldCIpOw0KIAkJCXJldCA9
IF9fZGlzcG9zZV9idWZmZXIoamgsDQogCQkJCQlqb3VybmFsLT5qX3J1bm5pbmdfdHJhbnNhY3Rp
b24pOw0KKwkJCWpvdXJuYWxfcHV0X2pvdXJuYWxfaGVhZChqaCk7DQogCQkJc3Bpbl91bmxvY2so
JmpvdXJuYWwtPmpfbGlzdF9sb2NrKTsNCiAJCQlqYmRfdW5sb2NrX2JoX3N0YXRlKGJoKTsNCiAJ
CQlzcGluX3VubG9jaygmam91cm5hbC0+al9zdGF0ZV9sb2NrKTsNCi0JCQlqb3VybmFsX3B1dF9q
b3VybmFsX2hlYWQoamgpOw0KIAkJCXJldHVybiByZXQ7DQogCQl9IGVsc2Ugew0KIAkJCS8qIFRo
ZXJlIGlzIG5vIGN1cnJlbnRseS1ydW5uaW5nIHRyYW5zYWN0aW9uLiBTbyB0aGUNCkBAIC0xNzg5
LDEwICsxNzg5LDEwIEBAIHN0YXRpYyBpbnQgam91cm5hbF91bm1hcF9idWZmZXIoam91cm5hbF8N
CiAJCQkJSkJVRkZFUl9UUkFDRShqaCwgImdpdmUgdG8gY29tbWl0dGluZyB0cmFucyIpOw0KIAkJ
CQlyZXQgPSBfX2Rpc3Bvc2VfYnVmZmVyKGpoLA0KIAkJCQkJam91cm5hbC0+al9jb21taXR0aW5n
X3RyYW5zYWN0aW9uKTsNCisJCQkJam91cm5hbF9wdXRfam91cm5hbF9oZWFkKGpoKTsNCiAJCQkJ
c3Bpbl91bmxvY2soJmpvdXJuYWwtPmpfbGlzdF9sb2NrKTsNCiAJCQkJamJkX3VubG9ja19iaF9z
dGF0ZShiaCk7DQogCQkJCXNwaW5fdW5sb2NrKCZqb3VybmFsLT5qX3N0YXRlX2xvY2spOw0KLQkJ
CQlqb3VybmFsX3B1dF9qb3VybmFsX2hlYWQoamgpOw0KIAkJCQlyZXR1cm4gcmV0Ow0KIAkJCX0g
ZWxzZSB7DQogCQkJCS8qIFRoZSBvcnBoYW4gcmVjb3JkJ3MgdHJhbnNhY3Rpb24gaGFzDQpAQCAt
MTgxMywxMCArMTgxMywxMCBAQCBzdGF0aWMgaW50IGpvdXJuYWxfdW5tYXBfYnVmZmVyKGpvdXJu
YWxfDQogCQkJCQlqb3VybmFsLT5qX3J1bm5pbmdfdHJhbnNhY3Rpb24pOw0KIAkJCWpoLT5iX25l
eHRfdHJhbnNhY3Rpb24gPSBOVUxMOw0KIAkJfQ0KKwkJam91cm5hbF9wdXRfam91cm5hbF9oZWFk
KGpoKTsNCiAJCXNwaW5fdW5sb2NrKCZqb3VybmFsLT5qX2xpc3RfbG9jayk7DQogCQlqYmRfdW5s
b2NrX2JoX3N0YXRlKGJoKTsNCiAJCXNwaW5fdW5sb2NrKCZqb3VybmFsLT5qX3N0YXRlX2xvY2sp
Ow0KLQkJam91cm5hbF9wdXRfam91cm5hbF9oZWFkKGpoKTsNCiAJCXJldHVybiAwOw0KIAl9IGVs
c2Ugew0KIAkJLyogR29vZCwgdGhlIGJ1ZmZlciBiZWxvbmdzIHRvIHRoZSBydW5uaW5nIHRyYW5z
YWN0aW9uLg0K

--=-NH6nALFO9biDlEuRc9gQ--
