Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWADKk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWADKk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWADKk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:40:56 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:25798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751237AbWADKkz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:40:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GLyLayl3EN9lvsZ1SNAQ0dX2dXq5+tslg7UjXBhs8EE9L9+//izWAoDojtmEGYuJ/cvYSHpdi0K1Rt5M5Va5Xmxx+8DfjslLrDLqN7DR5bXRc+1m98EPc4Amp4rk8OMXzWMLMhpmgJoGogkh4QiCu4hFvIkXsdyb+rj+uqMsA6o=
Message-ID: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:40:54 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what is the state of current after an mm_fault occurs?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
       In my opinion, the state of current should be TASK_RUNNING
after an mm_fault occurs.But I donot know why the function of
handle_mm_fault() set the state of current TASK_RUNNING.
/*
 * By the time we get here, we already hold the mm semaphore
 */
int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
	unsigned long address, int write_access)
{
	pgd_t *pgd;
	pmd_t *pmd;

	__set_current_state(TASK_RUNNING);
	pgd = pgd_offset(mm, address);

	inc_page_state(pgfault);

	if (is_vm_hugetlb_page(vma))
		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */

	/*
	 * We need the page table lock to synchronize with kswapd
	 * and the SMP-safe atomic PTE updates.
	 */
	spin_lock(&mm->page_table_lock);
	pmd = pmd_alloc(mm, pgd, address);

	if (pmd) {
		pte_t * pte = pte_alloc_map(mm, pmd, address);
		if (pte)
			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
	}
	spin_unlock(&mm->page_table_lock);
	return VM_FAULT_OOM;
}

any help will be preferred.
Thank you!!

Jeff
